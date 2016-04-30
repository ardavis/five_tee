Then(/^the "([^"]*)" modal should pop up$/) do |name|
  expect(page).to have_css(".#{name.downcase.split(' ').join('.')}")
end

When(/^I give the task a title$/) do
  @title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
  fill_in('new_task[title]', with: @title)
end

When(/^I give the task a tag$/) do
  @tag = Faker::Hipster.word
  find('#tag_dropdown').click
  click_link 'Create New Tag'
  fill_in('new_task[tag]', with: @tag)
  find('#save_tag').click
end

When(/^choose a date$/) do
  find('#new_task_duedate').click
  first('.day').click
end

When(/^add a description$/) do
  @desc = Faker::Hipster.paragraph(2)[0..199]
  fill_in('new_task_desc', with: @desc)
end


When(/^click Save$/) do
  click_link 'Save'
end

When(/^I click on the edit "([^"]*)" button$/) do |attr|
  id = "##{attr.gsub(' ', '_')}_label"
  find(id).find('.glyphicon-pencil').click
end

When(/^I fill in a new "([^"]*)"$/) do |attr|
  fill_in "task_#{attr.gsub(' ', '_')}", with: send("new_#{attr.gsub(' ', '_')}")
end

When(/^save the new "([^"]*)"$/) do |attr|
  find("#save_#{attr.gsub(' ', '_')}").click
end

When(/^I fill in a new tag$/) do
  click_link 'Create New Tag'
  fill_in 'task_tag', with: new_tag
end

When(/^I fill in a new due date$/) do
  first('.day').click
end

When(/^I fill in a new duration/) do
  new_duration
  ['hours', 'mins', 'secs'].each {|d| fill_in "task_#{d}", with: @new_duration[d.to_sym]}
end

Then(/^I should see all my new data$/) do
  [@new_title, @new_desc, @new_tag, @new_duration.values].flatten.each {|a| expect(page).to have_content(a)}
end