When(/^I click on the "([^"]*)" link$/) do |name|
  name = name == 'task' ? @task.title : name
  click_on name
  sleep 1 if @task and name == @task.title
end

When(/^I click the "([^"]*)" button$/) do |name|
  btn = ".#{name}.btn"
  find(btn).click
end

When(/^I click OK$/) do
  page.driver.browser.switch_to.alert.accept
end
