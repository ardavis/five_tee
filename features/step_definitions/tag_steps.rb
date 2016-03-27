When(/^I create a tag$/) do
  find('#tag-dropdown').click
  click_link 'Create New Tag'
  @name = Faker::Hipster.word
  fill_in ('tag_name'), with: @name
  find('#new-tag-modal').find('input[value="Save"]').click
end