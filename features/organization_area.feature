Feature: Organization Areas

  Background:
    Given I have a sample tool stored
    And I am on the 'Tool Details' page

  Scenario: Displays the HL7 product family to which the tool is applicable
    Then I should see text 'FHIR'
    And I should see text 'V2'
    
  Scenario: Displays the categorization area (business purpose) of the tool
    Then I should see text 'Education'
    And I should see text 'Implementation'
    
  