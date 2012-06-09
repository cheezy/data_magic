$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'data_magic'

Before do
  DataMagic.yml_directory = nil
  DataMagic.yml = nil
end
