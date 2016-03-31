When(/^I create a tag$/) do
  find('#tag-dropdown').click
  click_link 'Create New Tag'
  @tag = Faker::Hipster.word
  fill_in ('tag_name'), with: @tag
  find('#new-tag-modal').find('input[value="Save"]').click
end

When(/^ I set the current tag to "([^"]*)"$/) do |index|
  @tag = current_user.tags.all.to_a[index]
end

Given(/^I have a tag$/) do
  @user = User.first
  @tag = @user.tags.create!(name: Faker::Hipster.word)
end

When(/^I click the delete tag button$/) do
  find('#tag-list').find('.btn-danger').click
end

When(/^I set the current tag to tag "([^"]*)"$/) do |index|
  @user = User.first
  @task = @user.tags.all.to_a[index.to_i-1]
end

Then(/^I should not see the tag$/) do
  expect(page).to_not have_content(@tag.name)
end