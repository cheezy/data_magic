require "data_magic/version"
require "data_magic/config"
require "data_magic/reader"

module DataMagic

  class << self
    def load(filename)
      @yml = reader.load_file(filename)
    end

    private
  
    def reader
      @reader ||= DataMagic::Reader.new
    end
  end
end
