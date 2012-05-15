require "data_magic/version"
require "data_magic/translation"
require 'yml_reader'

require 'faker'

module DataMagic
  include Translation
  extend YmlReader

  def data_for(key, additional={})
    DataMagic.load('default.yml') unless DataMagic.yml
    data = DataMagic.yml[key.to_s]
    prep_data data.merge(additional).clone
  end

  private

  def prep_data(data)
    data.each do |key, value|
      unless value.nil?
        next unless value.respond_to? '[]'
        data[key] = eval(value[1..-1]) if value[0,1] == "~"
      end
    end
    data
  end

  class << self
    attr_reader :yml
  
    def default_directory
      'config'
    end
  end

end
