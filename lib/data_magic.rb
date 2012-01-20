require "data_magic/version"
require "data_magic/config"
require "data_magic/reader"
require "data_magic/translation"

require 'faker'

module DataMagic
  include Translation

  def data_for(key)
    data = DataMagic.yml[key]
    prep_data data
  end

  private

  def prep_data(data)
    data.each { |key, value| data[key] = eval(value) }
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
