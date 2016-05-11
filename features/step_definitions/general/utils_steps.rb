Given(/^my browser is full screen$/) do
  page.driver.browser.manage.window.maximize
end

When(/^I wait a few seconds$/) do
  sleep (rand(2) + 1)
end