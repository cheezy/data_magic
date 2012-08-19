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
  @data = TestClass.new.data_for key
end


Then /^the value for "(.+)" should be "(.+)"$/ do |key, value|
  @data[key].should == value
end

Then /^the value for "(.+)" should be (true|false)$/ do |key, value|
  @data[key].should == eval(value)
end

Then /^the value for "(.+)" should be (\d+) word|words long$/ do |key, length|
  puts @data[key]
  @data[key].split(' ').size.should == length.to_i
end

Then /^the value for "(.+)" should have a minimum of (\d+) word|wordss$/ do |key, length|
  @data[key].split(' ').size.should >= length.to_i
end

Then /^the value for "(.+)" should exist$/ do |key|
  @data[key].should_not be_nil
end


When /^I load the file "(.+)"$/ do |file_name|
  DataMagic.load file_name
end
