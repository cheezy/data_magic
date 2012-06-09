Feature: Default file and directory functionality of the data_magic gem
  
  Scenario: Using the default file and directory
    Given I have read the default yaml file from the default location
    When I ask for the data for "dm"
    Then the value for "value1" should be "this is value 1"
    And the value for "value2" should be "this is value 2"

