# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

if ENV['coverage']
  raise "simplecov only works on Ruby 1.9" unless RUBY_VERSION =~ /^1\.9/

  require 'simplecov'
  SimpleCov.start { add_filter "spec/" }
end

require 'rspec'

require 'data_magic'

RSpec::Matchers.define :have_field_value do |expected|
  supports_block_expectations
  match do |actual|
    actual['field'] === expected
  end
  
  failure_message do |actual|
    "expected '#{expected}' to equal the field value '#{actual['field']}'"
  end
  
  failure_message_when_negated do |actual|
    "expected '#{expected}' to not equal to field value '#{actual['field']}'"
  end
end


