Then(/^I should see the "([^"]*)" task$/) do |type|
  expect(page).to have_content(@title)
end

Given(/^I have created a task$/) do
  click_link 'New Task'
  @title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
  fill_in 'Title:', with: @title
  find('input[value="Save"]').click
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
end