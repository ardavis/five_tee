class ArchivesController < ApplicationController

  include TasksHelper

  def index
    respond_to do |format|
      format.html do
        render component: 'ArchivesIndex', props: {archives: archives_hash}
      end
    end
  end

  def new
    @archive = current_user.archives.new()
    if @archive.save
      current_user.tasks.where(archive_id: nil).each do |task|
        @task = current_user.tasks.create(task.dup.attributes)
        @task.update(
            archive_id: @archive.id,
            created_at: task.created_at,
            archive_tag: task.tag_id ?  Tag.find(task.tag_id).name : nil)
      end
        respond_to do |format|
        format.json { render json: archives_hash}
      end
    end
  end

  private

  def archives_hash
    archives = []
    current_user.archives.each do |a|
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
    if current_user.session.filter_tag_id
      filtered_tasks = current_user.tasks
                           .where(tag_id: current_user.session.filter_tag_id)
                           .order(current_user.session.sort_sql)
    else
      filtered_tasks = current_user.tasks
                           .order(current_user.session.sort_sql)
    end
    {
        incomplete: filtered_tasks.where(completed_at: nil).where(archive_id: id).map{|task| react_task(task)},
        complete: filtered_tasks.where.not(completed_at: nil).where(archive_id: id).map{|task| react_task(task)}
    }
  end

end