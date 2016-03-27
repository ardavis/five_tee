@javascript
Feature:
  As a user
  I want to have, and interact with, tasks


  Scenario: Create new task
    Given I am logged in
    When I click on the "New Task" link
    Then the "New Task" modal should pop up
    When I give the task a title
    And I create a tag
    And choose a date
    And add a description
    And click Save
    When I click "Close"
    Then I should see the "new" task
    When I click on the "Task" link
    Then I should see all the data I put in

  Scenario: Edit task
    Given I am logged in
    And I have created a task
    When I click on the "Task" link
    Then the "Show Task" modal should pop up
    When I click on the "Edit" link
    Then the "Edit Task" modal should pop up
    When I append to the title
    And I create a tag
    And add a description
    And edit the duration
    And click Save
    When I click "Close"
    Then I should see the "edited" task
    When I click on the "Task" link
    Then I should see all the data I put in

  Scenario: Start and pause a task
    Given I am logged in
    And I have created a task
    When I click on the "Play" button
    Then I should see the "Pause" button
    And the timer should be working
    When I click on the "Pause" button
    Then I should see the "Play" button
    And the timer should be paused

  Scenario: Complete and restart a task
    Given I am logged in
    And I have created a task
    When I click on the "Complete" button
    Then I should see the task in "Completed Tasks"
    When I click on the "Restart" button
    Then I should see the task in "Incompleted Tasks"

  Scenario: Deleting a task
    Given I am logged in
    And I have created a task
    When I click on the "Delete" button
    And I click OK
    Then I shouldn't see the task

