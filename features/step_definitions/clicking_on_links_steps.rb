When(/^I click on the "([^"]*)" link$/)  do |name|
  name = name == "Task" ? @title : name
  click_link name
end