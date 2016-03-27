Then(/^I should see the "([^"]*)" task$/) do |type|
  expect(page).to have_content(@title)
end

Given(/^I have created a task$/) do
  click_link 'New Task'
  @title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
  fill_in 'Title:', with: @title
  find('input[value="Save"]').click
end

