Given(/^I have an account$/) do
  @email = Faker::Internet.email
  @password = Faker::Internet.password(8)
  User.create! email: @email, password: @password, password_confirmation: @password
end

Given(/^I log in$/) do
  visit '/'
  fill_in 'Email', with: @email
  fill_in 'Password', with: @password
  find('input[value="Log in"]').click
end

When(/^I try to visit the root page$/) do
  visit '/'
end

Then(/^I am asked to log in$/) do
  expect(page).to have_content('You need to sign in or sign up before continuing.')
end

When(/^I submit my log in info$/) do
  fill_in 'Email', with: @email
  fill_in 'Password', with: @password
  find('input[value="Log in"]').click
end

Then(/^I should be on the root page$/) do
  expect(page).to have_content('Tasks')
  expect(page).to have_content('Completed Tasks')
end

Given(/^I am logged in$/) do
  @email = Faker::Internet.email
  @password = Faker::Internet.password(8)
  User.create! email: @email, password: @password, password_confirmation: @password
  visit '/'
  fill_in 'Email', with: @email
  fill_in 'Password', with: @password
  find('input[value="Log in"]').click
end