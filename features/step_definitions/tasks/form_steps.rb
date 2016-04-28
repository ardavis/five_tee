Then(/^the "([^"]*)" modal should pop up$/) do |name|
  expect(page).to have_css(".#{name.downcase.split(' ').join('.')}")
end

When(/^I give the task a title$/) do
  fill_in('new_task[title]', with: 'title')
end

When(/^I give the task a tag$/) do
  find('#tag_dropdown').click
  click_link 'Create New Tag'
  fill_in('new_task[tag]', with: 'tag')
  find('#save_tag').click
end

When(/^choose a date$/) do
  find('#new_task_duedate').click
  first('.day').click
end

When(/^add a description$/) do
  fill_in('new_task_desc', with: 'description')
end


When(/^click Save$/) do
  click_link 'Save'
end