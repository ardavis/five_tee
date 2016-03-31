@javascript

Feature:
  As a user with at least one task
  I would like to edit my tasks

  Background:
    Given I have an account
    And I have a task
    And I log in

  Scenario: Deleting a task
    When I click on the delete button
    And I click OK
    Then I shouldn't see the task