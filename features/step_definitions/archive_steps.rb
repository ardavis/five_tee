Given(/^I have an archive$/) do
  @user = User.first
  @archive = @user.archives.create!
  @archived_task = @task.dup
  @archived_task.update(archive_id: @archive.id, archive_tag: @task.tag_id ?  Tag.find(@task.tag_id).name : nil)
  @archived_task.update(created_at: @task.created_at)
  @archived_task.save
end

Then(/^I should see the archive$/) do
  expect(page).to have_content(@archive.created_at.in_time_zone('America/New_York').strftime('%m-%d-%Y %I:%M %P'))
end

Then(/^I should not see the archive$/) do
  expect(page).to_not have_content(@archive.created_at.in_time_zone('America/New_York').strftime('%m-%d-%Y %I:%M %P'))
end