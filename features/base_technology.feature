Feature: Base Technology

  Background:
    Given I have a sample tool stored
    And I am on the 'Tool Details' page

  Scenario: Displays base technologies for a tool
    Then I should see Technologies label

  Scenario: Displays base technology version
    Then I should see text 'v1.8'

  Scenario: Displays tool dependencies
    Then I should see Dependencies label