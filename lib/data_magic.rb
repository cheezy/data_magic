require 'data_magic/core_ext/string'
require 'data_magic/core_ext/fixnum'
require "data_magic/version"
require "data_magic/translation"
require 'yml_reader'
require 'faker'

module DataMagic
  extend YmlReader

  attr_reader :parent

  I18n.enforce_available_locales = false if I18n.respond_to? :enforce_available_locales

  def self.included(cls)
    @parent = cls
    translators.each do |translator|
      Translation.send :include, translator
    end
  end

  def data_for(key, additional={})
    if key.is_a?(String) && key.match(%r{/})
      filename, record = key.split('/')
      DataMagic.load("#{filename}.yml")
    else
      record = key.to_s
      DataMagic.load(the_file) unless DataMagic.yml
    end
    data = DataMagic.yml[record]
    raise ArgumentError, "Undefined key #{key}" unless data
    prep_data data.merge(additional).clone
  end

  private

  def the_file
    ENV['DATA_MAGIC_FILE'] ? ENV['DATA_MAGIC_FILE'] :  'default.yml'
  end

  def prep_data(data)
    data.each do |key, value|
      unless value.nil?
        next if !value.respond_to?('[]') || value.is_a?(Numeric)
        data[key] = translate(value[1..-1]) if value[0,1] == "~"
      end
    end
    data
  end

  def translate(value)
    translation.send :process, value
  end

  def translation
    @translation ||= Translation.new parent
  end

  class << self
    attr_accessor :yml
  
    def default_directory
      'config/data'
    end

    def add_translator(translator)
      translators << translator
    end

    def translators
      @translators ||= []
    end
  end

end
