@javascript

Feature:
  Users should be able to delete tasks

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen


  Scenario: Deleting a task
    When I click on the delete button
    And I click OK
    Then I shouldn't see the task