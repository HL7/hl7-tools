Feature: Health and Risk assessment

  Background:
    Given I have a sample tool stored
    And I am on the 'Tool Details' page

  Scenario: Displays the most recent assessment for the tool
    Then I should see Assessment label