@javascript

Feature: Filter tasks by tag via the dropdown

  Background:
    Given I have an account
    And I have two tasks with different tags
    And I log in

  Scenario:
    When I set the current tag to tag "1"
    And I filter the tasks by the current tag
    Then I should only see tasks with that tag
    When I set the current tag to tag "2"
    And I filter the tasks by the current tag
    Then I should only see tasks with that tag
    When I filter the tasks by all tags
    Then I should see all the tasks