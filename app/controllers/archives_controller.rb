class ArchivesController < ApplicationController

  include TasksHelper

  def index
    redirect_to '/tasks/index' and return unless current_user.session
    current_user.session.update_attributes(filter_tag_id: nil, sort_sql: 'created_at DESC')
    respond_to do |format|
      format.html do
        render component: 'ArchivesIndex', props: {archives: archives_hash}
      end
    end
  end

  def new
    @archive = current_user.archives.new()
    if @archive.save
      filtered_tasks.where(archive_id: nil).order(current_user.session.sort_sql).each do |task|
        @task = current_user.tasks.create(task.dup.attributes)
        @task.update(
            archive_id: @archive.id,
            created_at: task.created_at,
            archive_tag: (task.tag_id and task.tag_id != 0) ?  Tag.find(task.tag_id).name : nil,
            created_at: Time.now)
      end
      respond_to do |format|
        format.json { render json: {}}
      end
    end
  end

  def delete
    @archive = current_user.archives.find(archive_params[:id])
    if @archive.destroy
      current_user.tasks.where(archive_id: @archive.id).destroy_all
      respond_to do |format|
        format.json { render json: archives_hash}
      end
    end
  end

  def reset
    @archive = current_user.archives.new()
    if @archive.save
      filtered_tasks.where(archive_id: nil).order(current_user.session.sort_sql).each do |task|
        @task = current_user.tasks.create(task.dup.attributes)
        @task.update(
            archive_id: @archive.id,
            created_at: task.created_at,
            archive_tag: task.tag_id ?  Tag.find(task.tag_id).name : nil,
            created_at: Time.now)
      end
      filtered_tasks.where(archive_id: nil).each{ |task| task.update_attributes(completed_at: nil, duration: nil)}
      respond_to do |format|
        format.json {render json: tasks_hash}
      end
    end
  end

  private

  def archives_hash
    archives = []
    current_user.archives.order('created_at DESC').each do |a|
      archive = {
          created_at: a.created_at,
          created_at_display: a.created_at.in_time_zone('America/New_York').strftime('%m-%d-%Y %I:%M %P'),
          id: a.id,
          tasks: archive_tasks_hash(a.id)
      }
      archives.push(archive)
    end
    archives
  end


  def archive_tasks_hash(id)
    {
        incomplete: filtered_tasks.where(completed_at: nil)
                                  .where(archive_id: id)
                                  .order('created_at ASC')
                                  .map{|task| react_task(task)},

        complete: filtered_tasks.where.not(completed_at: nil)
                                .where(archive_id: id)
                                .order('created_at ASC')
                                .map{|task| react_task(task)}
    }
  end



  def archive_params
    params.require(:archive).permit(:id)
  end

end