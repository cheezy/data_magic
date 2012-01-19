module DataMagic
  module Config

    class << self
      attr_accessor :data_magic_yml_directory
      
      def yml_directory
        @data_magic_yml_directory ||= 'config'
      end
    end
    
  end
end
