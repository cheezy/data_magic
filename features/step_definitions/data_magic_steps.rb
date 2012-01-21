class TestClass
  include DataMagic
end


Given /^I have read the yaml file$/ do
  DataMagic.load "example.yml"
end

When /^I ask for the data for "([^\"]*)"$/ do |key|
  @data = TestClass.new.data_for key
end


Then /^the value for "([^\"]*)" should be "([^\"]*)"$/ do |key, value|
  @data[key].should == value
end

