@javascript

Feature:
  Users should be able to edit tasks

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen


  Scenario: Edit task
    When I click on the "task" link
    Then the "Show Task" modal should pop up
    When I click on the "Edit" link
    Then the "Edit Task" modal should pop up
    When I append to the title
    And I create a tag
    And add a description
    And edit the duration
    And click Save
    When I click "Close"
    When I set the current task to task "1"
    Then I should see the task
    When I click on the "task" link
    Then I should see all the data I put in