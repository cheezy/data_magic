$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'data_magic'

DataMagic::Config.yml_directory = 'features/yaml'
