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