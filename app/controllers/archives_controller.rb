class ArchivesController < ApplicationController

  before_action :get_sorted_tasks, only: [:create]

  before_action :get_task, only: [:show]

  before_action :get_archive, only: [:destroy]
  include TasksHelper

  def create
    @current_tasks = filtered_sorted_tasks(@completed_tasks)
    if @current_tasks.count > 0
      @archive = current_user.archives.create!
      @current_tasks.each do |task|
        task.update(archive_id: @archive.id, archive_tag: task.tag_id ?  Tag.find(task.tag_id).name : nil)
        task.update(completed_at: Time.now) unless task.completed_at
      end
    end
    redirect_to root_path
  end

  def show
    @archives = current_user.archives.paginate(:page => params[:page], :per_page => 3)
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
