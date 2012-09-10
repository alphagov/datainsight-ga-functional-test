Feature: Guide Format - Find a job

  Scenario: Google Analytics Initialization
    Given I am on the "/find-job/introduction" page
    Then the google analytics account should be "UA-33336744-1"
    And the google analytics domain should be "none"
    And the "Section" should be "work" at "page-level"
    And the "Format" should be "guide" at "page-level"
    And the "NeedID" should be "666" at "page-level"
    And the "Proposition" should be "citizen" at "page-level"

  Scenario: Entry Guide Events Tracking
    Given I am on the "/find-job/introduction" page
    Then the event "Entry" for "MS_guide" will be triggered


  Scenario: Success Guid Events Tracking
    Given I am on the "/find-job/introduction" page
    And I wait for 7 seconds
    Then the event "Success" for "MS_guide" will be triggered
