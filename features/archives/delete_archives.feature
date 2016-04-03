@javascript

Feature:
  Users should be able to archive tasks

  Background:
    Given I have an account
    And I have a task
    And I have an archive
    And I log in
    And my browser is full screen


  Scenario: Archive tasks
    When I click on the "View Archives" link
    Then I should see the archive
    And I click on the "delete" button
    And I click OK
    Then I should not see the archive
    

