When(/^I click on the "([^"]*)" link$/)  do |name|
  @user = User.first
  name = name == 'task' ? @task.title : name
  name = name == 'latest archive' ? @user.archives.last.created_at.in_time_zone('America/New_York').strftime('%m-%d-%Y %I:%M %P') : name
  click_link name
end