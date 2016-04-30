Feature: Users should be able to interact with tasks via the buttons

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen


  Scenario: Start and pause buttons work
    When I set the current task to task "1"
    When I take note of the current duration
    And I click the "play" button
    And I wait a few seconds
    Then the current duration should be different
    When I click the "pause" button
    And I take note of the current duration
    And I wait a few seconds
    Then the current duration should be the same

