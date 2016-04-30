When(/^I click on the "([^"]*)" link$/) do |name|
  name = name == 'task' ? @task.title : name
  click_on name
  sleep 1 if @task and name == @task.title
end

