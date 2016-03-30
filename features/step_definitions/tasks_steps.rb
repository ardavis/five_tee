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
  @desc = Faker::Hipster.paragraph(2)[0..199]
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

When(/^I click on the delete button$/) do
  find('.incompleted_tasks').find('.delete_btn').click
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

Given(/^I create a task with a tag$/) do
  click_link 'New Task'
  @title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
  fill_in 'Title:', with: @title
  find('#tag-dropdown').click
  click_link 'Create New Tag'
  @tag = Faker::Hipster.word
  fill_in ('tag_name'), with: @tag
  find('#new-tag-modal').find('input[value="Save"]').click
  find('input[value="Save"]').click
  click_button 'Close'
end

When(/^I create another task with a tag$/) do
  click_link 'New Task'
  @other_title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
  fill_in 'Title:', with: @other_title
  find('#tag-dropdown').click
  click_link 'Create New Tag'
  @other_tag = Faker::Hipster.word
  fill_in ('tag_name'), with: @other_tag
  find('#new-tag-modal').find('input[value="Save"]').click
  find('input[value="Save"]').click
  click_button 'Close'
end

Then(/^I should only see the "([^"]*)" task$/) do |task|
  tasks = find('.incompleted_tasks')
  if task == 'first'
    expect(tasks).to have_content(@task)
    expect(tasks).to_not have_content(@other_title)
  elsif task == 'second'
    expect(tasks).to have_content(@other_title)
    expect(tasks).to_not have_content(@title)
  end
end

When(/^I filter by the "([^"]*)" tag$/) do |tag|
  find('#filter_dropdown').click
  if tag == 'first'
    click_link @tag
  elsif tag == 'second'
    click_link @other_tag
  end
end

When(/^I filter by All Tags$/) do
  find('#filter_dropdown').click
  click_link 'All Tags'
end

When(/^I sort by "([^"]*)"$/) do |sort|
  find('#sort_dropdown').click
  click_link sort
end

Then(/^I should see the "([^"]*)" task first$/) do |task|
  if task == 'first'
    expect(first('h4')).to have_content(@title)
  elsif task == 'second'
    expect(first('h4')).to have_content(@other_title)
  end
end