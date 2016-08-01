Feature: Key Resources

  Background:
    Given I have a sample tool stored
    And I am on the 'Tool Details' page

  Scenario: Displays the tracker URL for the tool
    Then I should see the link 'Tool Issues' with an address of 'http://somewhere.org/track'
    
  Scenario: Displays the URL of the organization that created/maintains the tool
    Then I should see the link 'Tool Homepage' with an address of 'http://somewhere.org/x'
    
  Scenario: Displays the email of the contact for the tool creator
    Then I should see text 'someone@somewhere.com'
    
  Scenario: Displays the name of the tool creator
    Then I should see text 'Joe Hacker'
    
  Scenario: Displays the roles of the various people who work on the tool
    Then  I should see text 'Developer'
    
  Scenario: Displays the phone numbers for the people who work on the tool
    Then I should see text '+1 780-903-0885'