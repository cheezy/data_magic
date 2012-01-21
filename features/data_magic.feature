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

  Scenario: Getting addresses from the yaml
    Then the value for "street" should have a minimum of 2 words
    And the value for "city" should have a minimum of 1 word
    And the value for "state" should have a minimum of 1 word
    And the value for "state_ab" should be 1 word long
    And the value for "zip" should be 1 word long
    And the value for "country" should have a minimum of 1 word
    And the value for "second_address" should have a minimum of 1 words

  Scenario: Getting a company name from the yaml
    Then the value for "company" should have a minimum of 1 word

  Scenario: Getting an email address from the yaml
    Then the value for "email" should be 1 word long

  Scenario: Getting a phone number
    Then the value for "phone" should have a minimum of 1 word

  Scenario: Random phrases
    Then the value for "catch_phrase" should exist
    And the value for "words" should exist
    And the value for "sentence" should exist
    And the value for "sentences" should exist
    And the value for "paragraphs" should exist

