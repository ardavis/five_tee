Given(/^my browser is full screen$/) do
  page.driver.browser.manage.window.maximize
end