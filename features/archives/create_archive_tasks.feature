@javascript

Feature:
  Users should be able to archive tasks

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen


  Scenario: Archive tasks
    When I click on the "Archive Tasks" link
    And I click OK
    When I click on the "View Archives" link
    And I click on the "latest archive" link
    And  I set the current task to task "1"
    Then I should see the task
