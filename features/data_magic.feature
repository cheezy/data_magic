Feature: Functionality of the data_magic gem
  
  Background:
    Given I have read the yaml file
    When I ask for the data for "dm"

  Scenario: Getting basic data from the yaml
    Then the value for "value1" should be "this is value 1"
    And the value for "value2" should be "this is value 2"

  Scenario: Getting names from the yaml
    Then the value for "full_name" should have a minimum of 2 words
    And the value for "first_name" should be 1 word long
    And the value for "last_name" should be 1 word long

