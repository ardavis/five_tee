Then(/^I should see the "([^"]*)" task$/) do |type|
  expect(page).to have_content(@title)
end

Given(/^I have created a task$/) do
  click_link 'New Task'
  @title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
  fill_in 'Title:', with: @title
  find('input[value="Save"]').click
  click_button 'Close'
end


When(/^choose a date$/) do
  find('#task_due_date').click
  first('td').click
  @date = find('#task_due_date').native.attribute('value')
end

When(/^add a description$/) do
  @desc = Faker::Hipster.paragraph(2)
  fill_in 'Description:', with: @desc
end

Then(/^I should see all the data I put in$/) do
  show_modal = find('#show-task-modal')
  expect(show_modal).to have_content(@title)
  expect(show_modal).to have_content(@tag)
  expect(show_modal).to have_content(@date)
  expect(show_modal).to have_content(@desc)
  expect(show_modal).to have_content(@hours) if @hours
  expect(show_modal).to have_content(@mins) if @mins
  expect(show_modal).to have_content(@secs) if @secs
end


When(/^edit the duration$/) do
  click_link 'edit duration'
  @hours = rand(9) + 1
  @mins = rand(58) + 1
  @secs = rand(58) + 1
  find('input[name="hours_input"]').set(@hours)
  find('input[name="mins_input"]').set(@mins)
  find('input[name="secs_input"]').set(@secs)
  find('#duration-modal').find('#save_task_btn').click
end

When(/^I click on the "([^"]*)" button$/) do |name|
  button_class = '.' + name.downcase + '_btn'
  find(button_class).click
end

Then(/^I should see the "([^"]*)" button$/) do |name|
  button_class = '.' + name.downcase + '_btn'
  button = find(button_class)
  expect(button).to be_present
end

Then(/^I should see the task in "([^"]*)"$/) do |name|
  list_class = '.' + name.downcase.split(' ').join('_')
  list = find(list_class)
  expect(list).to have_content(@title)
end

Then(/^I shouldn't see the task$/) do
  expect(page).to_not have_content(@title)
end