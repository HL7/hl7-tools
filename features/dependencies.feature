Feature: Dependencies

  Background:
    Given I have a sample tool stored
    And I am on the 'Tool Details' page

  Scenario: Displays the dependencies on other items in the catalogue
    Then I should see Dependencies label
    
  Scenario: Displays the details of a dependency
    Then I should see text 'Core Tool'