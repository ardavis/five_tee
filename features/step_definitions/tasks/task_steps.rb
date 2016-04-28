When(/^I set the current task to task "([^"]*)"$/) do |index|
  @task = User.first.tasks.order('created_at DESC').to_a[index.to_i-1]
end

Then(/^I should see the task$/) do
  expect(page).to have_content(@task.title)
end

Then(/^I should see all the data I put in$/) do
  expect(page).to have_content(@task.title)
  expect(page).to have_content(@task.tag.name)
  expect(page).to have_content(@task.due_date.strftime('%m-%d-%Y'))
  expect(page).to have_content(@task.desc)
end