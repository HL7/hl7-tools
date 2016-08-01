Feature: Data Elements

  Background:
    Given I have a sample tool stored
    And I am on the 'Tool Details' page

  Scenario: Displays the home page URL for the tool
    Then I should see Tool Homepage label

  Scenario: Displays the description for the tool
    Then I should see text 'A sample tool description'

  Scenario: Displays the name of the tool
    Then I should see text 'Sample Tool 1'

  Scenario: Displays the purpose of the tool
    Then I should see Purpose label
    
  Scenario: Displays the version of the tool
    Then I should see text 'alpha'