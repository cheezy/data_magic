module DataMagic
  module Config

    class << self
      attr_accessor :data_magic_yml_directory

      #
      # retrieve the yml_directory - the location where all of the yml
      # files will be located.
      #
      def yml_directory
        @data_magic_yml_directory ||= 'config'
      end

      #
      # set the yml_directory - this is where the gem will look for
      # all of the yml files.
      #
      def yml_directory=(value)
        @data_magic_yml_directory = value
      end
      
    end
    
  end
end
