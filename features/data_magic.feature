Feature: Functionality of the data_magic gem

  Background:
    Given I have read the yaml file from features/yaml
    When I ask for the data for "dm"

  Scenario: Getting basic data from the yaml
    Then the value for "value1" should be "this is value 1"
    And the value for "value2" should be "this is value 2"

  Scenario: Getting names from the yaml
    Then the value for "full_name" should have a minimum of 2 words
    And the value for "first_name" should be 1 word long
    And the value for "last_name" should be 1 word long
    And the value for "name_prefix" should be 1 word long
    And the value for "name_suffix" should be 1 word long
    And the value for "title" should have a minimum of 3 words

  Scenario: Getting addresses from the yaml
    Then the value for "street" should have a minimum of 2 words
    And the value for "street_plus" should have a minimum of 4 words
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
    And the value for "email_plus" should include "buddy"
    And the value for "domain_name" should be 1 word long
    And the value for "user_name" should be 1 word long
    And the value for "url" should include "http://"

  Scenario: Getting a phone number
    Then the value for "phone" should be a phone number
    And the value for "cell" should be a phone number

  Scenario: Random phrases
    Then the value for "catch_phrase" should exist
    And the value for "words" should exist
    And the value for "sentence" should exist
    And the value for "sentences" should exist
    And the value for "paragraphs" should exist
    And the value for "characters" should be 255 characters long

  Scenario: Boolean values
    Then the value for "bool_true" should be true
    And the value for "bool_false" should be false

  Scenario: Reading multiple data segments
    When I ask for the data for "other"
    Then the value for "name" should be "Cheezy"
    And the value for "address" should be "123 Main Street"
    And the value for "email" should be "cheezy@example.com"

  Scenario: Reading from multiple yml files
    When I load the file "another.yml"
    And I ask for the data for "other_file"
    Then the value for "name" should be "Sneezy"
    And the value for "address" should be "555 Easy Money Drive"
    And the value for "email" should be "sneezy@example.com"

  Scenario: Reading multiple entries from same file
    When I load the file "another.yml"
    And I ask for the data for "other_file"
    Then the value for "name" should be "Sneezy"
    When I ask for the data for "more_info"
    Then the value for "name" should be "Wheezy"
    And the value for "address" should be "999 Alergy Ave"
    And the value for "email" should be "wheezy@example.com"

  Scenario: Returning a randomly selected value from an array
    Then the value for "random" should be either "Tom", "Dick", or "Harry"
    And the value for "range" should be between 1 and 5

  Scenario: Returning a sequential value from an array
    Then the first value for the sequential data should be "first"
    When I ask for the data again
    Then the second value for the sequential data should be "second"
    When I ask for the data again
    Then the third value for the sequential data should be "third"

  Scenario: Returning a value based on a mask
    Then the value for "mask" should begin with 3 numbers
    And the value for "mask" should have 3 upper case letters after a dash
    And the value for "mask" should end with 3 lower case letters

  Scenario: Returning dates
    Then the value for "today" should be today's date
    And the value for "tomorrow" should be tomorrow's date
    And the value for "yesterday" should be yesterday's date

  Scenario: Specifying number of days from today
    Then the value for "5daysfromtoday" should be five days from today
    And the value for "5daysago" should be five days ago

  Scenario: Getting a random month name
    Then the value for "some_month" should be a valid month

  Scenario: Getting a random month abbreviation
    Then the value for "month_abbr" should be a valid month abbreviation

  Scenario: Getting a random day name
    Then the value for "some_day" should be a valid day

  Scenario: Getting a random day abbreviation
    Then the value for "day_abbr" should be a valid day abbreviation

  Scenario: It should allow one to add new translator methods
    When I add the blah translator
    Then the value for "blah" should be "foobar"

  Scenario: Getting values from nested entries
    Then the nested value for this is_nested should be "Nested Value"

  Scenario Outline: Translate values from nested hahs
    Given overwrite @data with translate_nested
    Then the nested hash should include <key>
    And the value for "<key>" should <validate>
    And the value for "<key>" should not mach <negative_validate>
    Examples:
      | key        | validate                  | negative_validate |
      | full_name  | have a minimum of 2 words | ~full_name        |
      | first_name | be 1 word long            | ~first_name       |

  Scenario: Should be able to call the translator methods on DataMagic module
    Then I should be able to call the full_name translator
    And I should be able to call the state translator
    And I should be able to call the today translator
