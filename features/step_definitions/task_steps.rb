Given(/^I am on the home page$/) do
  visit '/'
end

When(/^I create a task$/) do
  click_on 'New Task'
  # STDIN.getc
  fill_in 'Title', with: 'This is a new task'
  fill_in 'Due date', with: '2016-02-17'
  fill_in 'Desc', with: 'This is a cool description'
  click_on 'Save'
  click_on 'Close'
end

Then(/^I should see that task$/) do
  expect(page).to have_content 'This is a new task'
end
