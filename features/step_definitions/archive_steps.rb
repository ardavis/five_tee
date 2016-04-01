Given(/^I have an archive$/) do
  @archive = current_user.archives.create!
  update_duration_if_running!(@task)
  @archived_task = @task.dup
  @archived_tasktask.update(archive_id: @archive.id, archive_tag: @task.tag_id ?  Tag.find(@task.tag_id).name : nil)
  @archived_tasktask.update(created_at: @task.created_at)
  @archived_tasktask.save
  end
end