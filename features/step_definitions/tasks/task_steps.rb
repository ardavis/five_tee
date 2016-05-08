Given(/^I have a task$/) do
  User.first.tasks.create(
      title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
      desc: Faker::Hipster.paragraph(2)[0..199],
      duration: rand(20000),
      due_date: "#{(rand(11)+1).to_s.rjust(2, '0')}-#{(rand(29)+1).to_s.rjust(2, '0')}-#{Time.now.year}"
  )
end

Given(/^I have two tasks with different tags$/) do
  tag = User.first.tags.new(name: Faker::Hacker.adjective)
  tag.save
  until User.first.tags.count == 2
    other_tag = User.first.tags.new(name: Faker::Hacker.adjective)
    other_tag.save
  end
  User.first.tasks.create(
      title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
      tag_id: tag.id,
      desc: Faker::Hipster.paragraph(2)[0..199],
      duration: rand(20000),
      due_date: "#{(rand(11)+1).to_s.rjust(2, '0')}-#{(rand(29)+1).to_s.rjust(2, '0')}-#{Time.now.year}"
  )
  User.first.tasks.create(
      title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
      tag_id: other_tag.id,
      desc: Faker::Hipster.paragraph(2)[0..199],
      duration: rand(20000),
      due_date: "#{(rand(11)+1).to_s.rjust(2, '0')}-#{(rand(29)+1).to_s.rjust(2, '0')}-#{Time.now.year}"
  )
end

Then(/^I should see all the tasks$/) do
  should_see = User.first.tasks
  should_see.each do |task|
    expect(page).to have_content(task.title)
  end
end


Then(/^I should only see tasks with that tag$/) do
  should_see = User.first.tasks.where(tag_id: @tag.id)
  should_not_see = User.first.tasks.where.not(tag_id: @tag.id)
  should_see.each do |task|
    expect(page).to have_content(task.title)
  end
  should_not_see.each do |task|
    expect(page).to_not have_content(task.title)
  end
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

When(/^I take note of the current task's duration$/) do
  @current_duration = dom_duration
end

Then(/^the current duration should be different$/) do
  expect(@current_duration).to_not eq dom_duration
end

Then(/^the current duration should be the same$/) do
  expect(@current_duration).to eq dom_duration
end

Then(/^the task should be in the "([^"]*)" section$/) do |name|
  section = find("div[id='#{name}_tasks'")
  expect(section).to have_content(@task.title)
end

Then(/^I should not see the task$/) do
  expect(page).to_not have_content(@task.title)
end