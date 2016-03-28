class ArchivesController < ApplicationController

  before_action :get_sorted_tasks, only: [:create]

  before_action :get_task, only: [:show]

  before_action :get_archive, only: [:destroy]
  include TasksHelper

  def create
    @current_tasks = filtered_sorted_tasks(current_user.tasks.where(archive_id: nil))
    if @current_tasks.count > 0
      @archive = current_user.archives.create!
      @current_tasks.each do |task|
        update_duration_if_running!(task)
        @task = task.dup
        @task.update(archive_id: @archive.id, archive_tag: task.tag_id ?  Tag.find(task.tag_id).name : nil)
        @task.update(created_at: task.created_at)
        @task.save
      end
    end
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
  end

  def show
    @archives = current_user.archives.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    current_user.tasks.where(archive_id: @archive.id).destroy_all
    @archive.destroy
    redirect_to show_archives_path
  end

  def archive_params
    params.require(:archive).permit(:id)
  end

  private

  def get_archive
    @archive = Archive.find(params[:id])
  end

end
