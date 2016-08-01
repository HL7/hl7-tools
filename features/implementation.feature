Feature: Implementation
  Tool implementation details

  Background:
    Given I have a sample tool stored
    And I am on the 'Tool Details' page

  Scenario: Displays the original date for the tool implementation
    Then I should see text '2016-05-12'

  Scenario: Displays the update date (rollout date) for the tool
    Then I should see text '2016-05-20'

  Scenario: Displays a list of internal/external users of the tool
    Then I should see Known Users label

  Scenario: Displays release notes that have been captured for the tool
    Then I should see text 'Sample note 1'
    And  I should see text 'Sample note 2'