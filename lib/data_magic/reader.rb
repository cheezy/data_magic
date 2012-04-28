require 'yaml'

module DataMagic
  class Reader
    #
    # load a file from the config directory and parse into a hash
    #
    def load_file(filename)
      YAML.load_file "#{::DataMagic::Config.yml_directory}/#{filename}"
    end
  end
end

