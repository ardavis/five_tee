@javascript

Feature: Users should be able to interact with tasks via the buttons

  Background:
    Given I have an account
    And I have a task
    And I log in


  Scenario: Start and pause buttons work
    When I set the current task to task "1"
    When I take note of the current task's duration
    And I click the "start" button
    And I wait a few seconds
    Then the current duration should be different
    When I click the "pause" button
    When I take note of the current task's duration
    And I wait a few seconds
    Then the current duration should be the same


  Scenario: Complete and restart buttons work
    When I set the current task to task "1"
    And I click the "complete" button
    Then the task should be in the "completed" section
    When I click the "restart" button
    Then the task should be in the "incomplete" section


   Scenario: Delete button works
     When I set the current task to task "1"
     And I click the "delete" button
     And I click OK
     Then I should not see the task
