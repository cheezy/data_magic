require 'data_magic/core_ext/string'
require 'data_magic/core_ext/integer'
require 'data_magic/core_ext/hash'
require 'data_magic/version'
require 'data_magic/translation'
require 'data_magic/date_translation'
require 'data_magic/standard_translation'
require 'yml_reader'
require 'faker'

module DataMagic
  extend YmlReader
  extend StandardTranslation
  extend DateTranslation

  attr_reader :parent

  I18n.enforce_available_locales = false if I18n.respond_to? :enforce_available_locales

  def self.locale=(value)
    Faker::Config.locale = value
  end

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
    prep_data(data.merge(additional.key?(record) ? additional[record] : additional).deep_copy)
  end

  # Given a scenario, load any fixture it needs.
  # Fixture tags should be in the form of @datamagic_FIXTUREFILE
  def self.load_for_scenario(scenario, fixture_folder = DataMagic.yml_directory)
    orig_yml_directory = DataMagic.yml_directory
    DataMagic.yml_directory = fixture_folder
    fixture_files = fixture_files_on(scenario)

    DataMagic.load "#{fixture_files.last}.yml" if fixture_files.count > 0
    DataMagic.yml_directory = orig_yml_directory
  end

  private

  def the_file
    ENV['DATA_MAGIC_FILE'] ? ENV['DATA_MAGIC_FILE'] : 'default.yml'
  end

  def prep_data(data)
    case data
      when Hash
        data.each {|key, value| data[key] = prep_data(value)}
      when Array
        data.each_with_index{|value, i|  data[i] = prep_data(value)}
      when String
        return translate(data[1..-1]) if data[0, 1] == '~'
    end
    data
  end

  def translate(value)
    translation.send :process, value
  rescue => error
    fail "Failed to translate: #{value}\n Reason: #{error.message}\n"
  end

  def translation
    @translation ||= Translation.new parent
  end

  # Load a fixture and merge it with an existing hash
  def self.load_fixture_and_merge_with(fixture_name, base_hash, fixture_folder = DEFAULT_FIXTURE_FOLDER)
    new_hash = load_fixture(fixture_name, fixture_folder)
    base_hash.deep_merge new_hash
  end

  def self.fixture_files_on(scenario)
    # tags for cuke 2, source_tags for cuke 1
    tags = scenario.send(scenario.respond_to?(:tags) ? :tags : :source_tags)
    tags.map(&:name).select {|t| t =~ /@datamagic_/}.map {|t| t.gsub('@datamagic_', '').to_sym}
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
