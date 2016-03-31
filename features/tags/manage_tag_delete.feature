@javascript

Feature:
  As a user with a tag
  I'd like to be able to delete
  them from the tag manage page

  Background:
    Given I have an account
    And I have a tag
    And I log in

    Scenario: Delete task from manage page
      When I click on the "Manage Tags" link
      Then the "Manage Tags" modal should pop up
      When I click the delete tag button
      And I click OK
      Then I should not see the tag
