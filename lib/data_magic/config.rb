module DataMagic
  module Config

    class << self
      attr_accessor :data_magic_yml_directory

      #
      # retrieve the yml_directory - the location where all of the yml
      # files will be located.
      #
      def yml_directory
        $stderr.puts "*** DEPRECATION WARNING"
        $stderr.puts "*** DataMagic::Config has being deprecated and will be removed soon."
        $stderr.puts "*** Please use DataMagic.yml_directory."
      end

      #
      # set the yml_directory - this is where the gem will look for
      # all of the yml files.
      #
      def yml_directory=(value)
        $stderr.puts "*** DEPRECATION WARNING"
        $stderr.puts "*** DataMagic::Config has being deprecated and will be removed soon."
        $stderr.puts "*** Please use DataMagic.yml_directory=."
      end
      
    end
    
  end
end
