@javascript

Feature:
  Users should be able to start and restart tasks

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen



  Scenario: Complete and restart a task
    When I click on the "Complete" button
    Then I should see the task in "Completed Tasks"
    When I click on the "Restart" button
    Then I should see the task in "Incompleted Tasks"