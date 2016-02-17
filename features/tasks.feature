Feature:
  As a user
  I want to create some tasks
  So that I can do my spot checks more efficiently

  @javascript
  Scenario: Create a task
    Given I am on the home page
    When I create a task
    Then I should see that task