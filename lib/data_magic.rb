require "data_magic/version"
require "data_magic/config"
require "data_magic/reader"
require "data_magic/translation"

require 'faker'

module DataMagic
  include Translation

  def data_for(key, additional={})
    DataMagic.load('default.yml') unless DataMagic.yml
    data = DataMagic.yml[key]
    prep_data data.merge(additional).clone
  end

  private

  def prep_data(data)
    data.each do |key, value|
      unless value.nil?
        next unless value.respond_to? '[]'
        data[key] = eval(value[1..-1]) if value[0] == "~"
      end
    end
    data
  end


  class << self
    attr_reader :yml
    
    #
    # load the provided filename from the config directory
    #
    def load(filename)
      @yml = reader.load_file(filename)
    end

    private
  
    def reader
      @reader ||= DataMagic::Reader.new
    end
  end
end
