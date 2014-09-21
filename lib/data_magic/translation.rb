require 'data_magic/date_translation'
require 'data_magic/standard_translation'

module DataMagic
  class Translation
    include StandardTranslation
    include DateTranslation

    def initialize(parent)
      @parent = parent
    end

  end
end
