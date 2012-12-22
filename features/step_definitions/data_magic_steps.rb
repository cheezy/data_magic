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
  @data[key].split(' ').size.should == length.to_i
end

Then /^the value for "(.+)" should have a minimum of (\d+) word|wordss$/ do |key, length|
  @data[key].split(' ').size.should >= length.to_i
end

Then /^the value for "(.*?)" should be (\d+) characters long$/ do |key, length|
  @data[key].length.should == length.to_i
end

Then /^the value for "(.+)" should exist$/ do |key|
  @data[key].should_not be_nil
end

When /^I load the file "(.+)"$/ do |file_name|
  DataMagic.load file_name
end

Then /^the value for "(.*?)" should be either "(.*?)", "(.*?)", or "(.*?)"$/ do |key, vala, valb, valc|
  [vala, valb, valc].should include @data[key]
end

Then /^the value for "(.*?)" should be between (\d+) and (\d+)$/ do |key, low, high|
  value = @data[key]
  value.should >= low.to_i
  value.should <= high.to_i
end

Then /^the value for "(.*?)" should begin with (\d+) numbers$/ do |key, num|
  value = @data[key]
  value[0,num.to_i].is_integer.should be_true
end

Then /^the value for "(.*?)" should have (\d+) upper case letters after a dash$/ do |key, num|
  value = @data[key]
  value[4,num.to_i].upcase.should == value[4,3]
end

Then /^the value for "(.*?)" should end with (\d+) lower case letters$/ do |key, num|
  value = @data[key]
  value[-1 * num.to_i,num.to_i].downcase.should == value[-3,3]
end

Then /^the value for "(.*?)" should include "(.*?)"$/ do |key, value|
  @data[key].should include value
end
