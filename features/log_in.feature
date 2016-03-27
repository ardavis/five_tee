@javascript
Feature:
  As a user
  I want the ability to log in

Scenario: Log in
  Given I have an account
  When I try to visit the root page
  Then I am asked to log in
  When I submit my log in info
  Then I should be on the root page