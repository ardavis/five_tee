class ArchivesController < ApplicationController
  def create
    @current_tasks = current_user.tasks.where(archive_id: nil)
    if @current_tasks.count > 1
      @archive = current_user.archives.create!
      @current_tasks.each do |task|
        task.update(archive_id: @archive.id, archive_tag: task.tag_id ?  Tag.find(task.tag_id).name : nil)
        task.update(completed_at: Time.now) unless task.completed_at
      end
    end
    redirect_to root_path
  end


  def show

  end

end
