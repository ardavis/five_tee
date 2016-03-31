When(/^I give the task a title$/) do
  title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
  fill_in 'Title:', with: title
end

When(/^click Save$/) do
  find('input[value="Save"]').click
end

When(/^I append to the title$/) do
  fill_in 'Title:', with: @task.title + '!'
end

When(/^I click OK$/) do
  page.driver.browser.switch_to.alert.accept
end