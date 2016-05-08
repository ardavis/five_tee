When(/^I set the current tag to tag "([^"]*)"$/) do |index|
  @tag = User.first.tags.to_a[index.to_i-1]
end

When(/^I filter the tasks by the current tag$/) do
  find('.filter.btn').click
  click_link @tag.name
end

When(/^I filter the tasks by all tags$/) do
  find('.filter.btn').click
  click_link 'All Tags'
end