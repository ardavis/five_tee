@javascript

Feature:
  Users should be able to start and pause tasks

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen


  Scenario: Start and pause a task
    When I set the current task to task "1"
    When I click on the "Play" button
    Then I should see the "Pause" button
    And the timer should be working
    When I click on the "Pause" button
    Then I should see the "Play" button
    And the timer should be paused