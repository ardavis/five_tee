@javascript
Feature:
  As a user
  I want to have, and interact with, tasks


  Scenario: Create new task
    Given I am logged in
    When I click on the "New Task" link
    Then the "New Task" modal should pop up
    When I give the task a title
    And click Save
    When I click "Close"
    Then I should see the "new" task

  Scenario: Edit task
    Given I am logged in
    And I have created a task
    When I click "Close"
    When I click on the "Task" link
    Then the "Show Task" modal should pop up
    When I click on the "Edit" link
    Then the "Edit Task" modal should pop up
    When I append to the title
    And click Save
    When I click "Close"
    Then I should see the "edited" task

