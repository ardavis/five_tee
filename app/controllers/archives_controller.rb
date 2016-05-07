class ArchivesController < ApplicationController

  def new
    @archive = current_user.archives.new()
    if @archive.save
      current_user.tasks.where(archive_id: nil).each do |task|
        @task = current_user.tasks.new(task)
        @task.update_attributes(archive_id: @archive.id)
      end
    end
  end

end