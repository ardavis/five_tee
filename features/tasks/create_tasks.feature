@javascript

Feature:
  As a user
  I want to create tasks

  Background:
    Given I am logged in

  Scenario: Create new task
    When I click on the "New Task" link
    Then the "New Task" modal should pop up
    When I give the task a title
    And I create a tag
    And choose a date
    And add a description
    And click Save
    When I click "Close"
    When I set the current task to task "1"
    Then I should see the task
    When I click on the "task" link
    Then I should see all the data I put in
