Given(/^I have a task$/) do
  User.first.tasks.create(
      title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
      desc: Faker::Hipster.paragraph(2)[0..199],
      duration: rand(20000),
      due_date: "#{(rand(11)+1).to_s.rjust(2, '0')}-#{(rand(29)+1).to_s.rjust(2, '0')}-#{Time.now.year}"
  )
end


When(/^I set the current task to task "([^"]*)"$/) do |index|
  @task = User.first.tasks.order('created_at DESC').to_a[index.to_i-1]
end

Then(/^I should see the task$/) do
  expect(page).to have_content(@task.title)
end

Then(/^I should see all the data I put in$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@tag)
  expect(page).to have_content(@task.due_date.strftime('%m-%d-%Y'))
  expect(page).to have_content(@desc)
end

When(/^I take note of the current duration$/) do
  @current_duration = find()
end