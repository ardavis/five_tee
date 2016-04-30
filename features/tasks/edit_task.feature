@javascript

Feature: Users should be able to edit their tasks

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen

  Scenario: Edit a task
    When I set the current task to task "1"
    And I click on the "task" link
    And I click on the edit "title" button
    And I fill in a new "title"
    And save the new "title"
    And I click on the edit "description" button
    And I fill in a new "description"
    And save the new "description"
    And I click on the edit "tag" button
    And I fill in a new tag
    And save the new "tag"
    And I click on the edit "due date" button
    And I fill in a new due date
    And save the new "due date"
    And I click on the edit "duration" button
    And I fill in a new duration
    And save the new "duration"
    Then I should see all my new data
