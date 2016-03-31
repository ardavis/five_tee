@javascript

Feature:
  As a user
  I want to have, and interact with, tasks

  Background:
    Given I have an account
    And I have a task
    And I log in


  Scenario: Complete and restart a task
    When I click on the "Complete" button
    Then I should see the task in "Completed Tasks"
    When I click on the "Restart" button
    Then I should see the task in "Incompleted Tasks"