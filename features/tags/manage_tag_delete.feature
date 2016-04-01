@javascript

Feature:
  Users should be able to delete tags

  Background:
    Given I have an account
    And I have a tag
    And I log in
    And my browser is full screen


  Scenario: Delete task from manage page
      When I click on the "Manage Tags" link
      Then the "Manage Tags" modal should pop up
      When I click the delete tag button
      And I click OK
      Then I should not see the tag
