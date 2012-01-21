Feature: Functionality of the data_magic gem

  Scenario: Getting basic data from the yaml
    Given I have read the yaml file
    When I ask for the data for "dm"
    Then the value for "value1" should be "this is value 1"
    And the value for "value2" should be "this is value 2"

