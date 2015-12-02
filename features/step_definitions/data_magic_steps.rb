class TestClass
  include DataMagic
end


Given /^I have read the yaml file from features\/yaml$/ do
  DataMagic.yml_directory = 'features/yaml'
  DataMagic.load "example.yml"
end

Given /^I have read the default yaml file from the default location$/ do

end

When /^I ask for the data for "(.+)"$/ do |key|
  TestClass.instance_variable_set "@private_firstsecond_index", 0
  @tc = TestClass.new
  @data = @tc.data_for key
end


Then /^the value for "(.+)" should be "(.+)"$/ do |key, value|
  expect(@data[key]).to eql value
end

Then /^the value for "(.+)" should be (true|false)$/ do |key, value|
  expect(@data[key]).to eql eval(value)
end

Then /^the value for "(.+)" should be (\d+) word|words long$/ do |key, length|
    expect(@data[key].split(' ').size).to eql length.to_i
end

Then /^the value for "(.+)" should have a minimum of (\d+) word|wordss$/ do |key, length|
  expect(@data[key].split(' ').size).to be >= length.to_i
end

Then /^the value for "(.*?)" should be (\d+) characters long$/ do |key, length|
  expect(@data[key].length).to eql length.to_i
end

Then /^the value for "(.+)" should exist$/ do |key|
  expect(@data[key]).not_to be_nil
end

When /^I load the file "(.+)"$/ do |file_name|
  DataMagic.load file_name
end

Then /^the value for "(.*?)" should be either "(.*?)", "(.*?)", or "(.*?)"$/ do |key, vala, valb, valc|
  expect([vala, valb, valc]).to include @data[key]
end

Then /^the value for "(.*?)" should be between (\d+) and (\d+)$/ do |key, low, high|
  value = @data[key]
  expect(value).to be >= low.to_i
  expect(value).to be <= high.to_i
end

Then /^the value for "(.*?)" should begin with (\d+) numbers$/ do |key, num|
  value = @data[key]
  expect(value[0,num.to_i].is_integer).to be true
end

Then /^the value for "(.*?)" should have (\d+) upper case letters after a dash$/ do |key, num|
  value = @data[key]
  expect(value[4,num.to_i].upcase).to eql value[4,3]
end

Then /^the value for "(.*?)" should end with (\d+) lower case letters$/ do |key, num|
  value = @data[key]
  expect(value[-1 * num.to_i,num.to_i].downcase).to eql value[-3,3]
end

Then /^the value for "(.*?)" should include "(.*?)"$/ do |key, value|
  expect(@data[key]).to include value
end

Then /^the value for "(.*?)" should be today\'s date$/ do |key|
  expect(@data[key]).to eql Date.today.strftime('%D')
end

Then /^the value for "(.*?)" should be tomorrow\'s date$/ do |key|
  tomorrow = Date.today + 1
  expect(@data[key]).to eql tomorrow.strftime('%D')
end

Then /^the value for "(.*?)" should be yesterday\'s date$/ do |key|
  yesterday = Date.today - 1
  expect(@data[key]).to eql yesterday.strftime('%D')
end

Then /^the value for "(.*?)" should be five days from today$/ do |key|
  the_day = Date.today + 5
  expect(@data[key]).to eql the_day.strftime('%D')
end

Then /^the value for "(.*?)" should be five days ago$/ do |key|
  the_day = Date.today - 5
  expect(@data[key]).to eql the_day.strftime('%D')
end

Then /^the value for "(.*?)" should be a valid month$/ do |key|
  months = %w[January February March April May June July August September October November December]
  expect(months).to include @data[key]
end

Then /^the value for "(.*?)" should be a valid month abbreviation$/ do |key|
  months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  expect(months).to include @data[key]
end

Then /^the value for "(.*?)" should be a valid day$/ do |key|
  days = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
  expect(days).to include @data[key]
end

Then /^the value for "(.*?)" should be a valid day abbreviation$/ do |key|
  days = %w[Sun Mon Tue Wed Thu Fri Sat]
  expect(days).to include @data[key]
end

When /^I add the blah translator$/ do
  module Blah
    def blah
      'foobar'
    end
  end
  DataMagic.add_translator(Blah)

  class TranslatorAdded
    include DataMagic
  end
  ta = TranslatorAdded.new
  @data = ta.data_for 'dynamic'
end

Then(/^the (?:first|second|third) value for the sequential data should be "(.*?)"$/) do |value|
  expect(@data['ordered']).to eql value
end

When(/^I ask for the data again$/) do
  @data = @tc.data_for 'dm'
end

Then(/^the nested value for this is_nested should be "(.*?)"$/) do |value|
  expect(@data['this']['is_nested']).to eql value
end

Then(/^the nested hash should include (.*?)$/) do |value|
  expect(@data.keys).to include value
end

Then(/^the value for "(.*?)" should be a phone number$/) do |value|
  phone = @data[value]
  if phone.split(' ').length == 2
    expect(phone).to include "("
    expect(phone).to include ")"
  else
    expect(phone.split(' ').length).to eql 1
  end
end

Then(/^I should be able to call the (.+) translator$/) do |method|
  value = DataMagic.send method
  expect(value).not_to be_empty
end


And(/^the value for "([^"]*)" should not mach (.*)$/) do |key, value|
  expect(@data[key]).not_to eql value
end


Given(/^overwrite @data with (.*)$/) do |hash|
  # This is a bit dangerous but quick way to make all steps to work with nested data
  @data = @data['this'][hash]
end