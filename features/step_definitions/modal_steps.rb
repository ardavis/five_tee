Then(/^the "([^"]*)" modal should pop up$/) do |name|
  modal_id = '#' + name.downcase.split(' ').join('-') + '-modal'
  name = name == 'Show Task' ? @task.title : name
  expect(find(modal_id)).to have_content(name)
end

When(/^I click "([^"]*)"$/) do |name|
  sleep 1
  click_button name
  sleep 1
end