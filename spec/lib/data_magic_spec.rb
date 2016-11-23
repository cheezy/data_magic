require 'spec_helper'

class UserPage
  include DataMagic
end

class MockScenario
  attr_accessor :tags
  def initialize(tags)
    @tags = tags
  end
end

class MockTag
  attr_reader :name, :line
  def initialize(name, line)
    @name = name
    @line = line
  end
end

describe DataMagic do
  context "when configuring the yml directory" do
    before(:each) do
      DataMagic.yml_directory = nil
    end
    
    it "should default to a directory named config" do
      expect(DataMagic.yml_directory).to eql 'config/data'
    end

    it "should store a yml directory" do
      DataMagic.yml_directory = 'test_dir'
      expect(DataMagic.yml_directory).to eql 'test_dir'
    end

    it "should accept and use locale" do
      expect(Faker::Config).to receive(:locale=).with('blah')
      DataMagic.locale = 'blah'
    end

  end

  context "when reading yml files" do
    it "should read files from the config directory" do
      DataMagic.yml = nil
      DataMagic.load("user.yml")
      data = UserPage.new.data_for "valid"
      expect(data.keys.sort).to eq(['job','name'])
    end

    it "should default to reading a file named default.yml" do
      DataMagic.yml_directory = 'config/data'
      DataMagic.yml = nil
      data = UserPage.new.data_for :dm
      expect(data.keys).to include('value1')
    end

    it "should use the value of DATA_MAGIC_FILE if it exists" do
      DataMagic.yml_directory = 'config/data'
      DataMagic.yml = nil
      ENV['DATA_MAGIC_FILE'] = 'user.yml'
      data = UserPage.new.data_for "valid"
      expect(data.keys.sort).to eq(['job','name'])
      ENV['DATA_MAGIC_FILE'] = nil
    end

    it 'should merge additional data to the same key if not present in addtional' do
      DataMagic.yml_directory = 'config/data'
      data = UserPage.new.data_for 'user/valid', {'job' => 'Overlord'}
      expect(data['job']).to eq('Overlord')
    end
    it 'should merge additional data to resulting hash if present in additional data' do
      DataMagic.yml_directory = 'config/data'
      data = UserPage.new.data_for 'user/valid', { 'valid' => {'job' => 'Overlord'} }
      expect(data['job']).to eq('Overlord')
    end
  end

  context "namespaced keys" do
    it "loads correct file and retrieves data" do
      DataMagic.yml_directory = 'config/data'
      data = UserPage.new.data_for "user/valid"
      expect(data.keys.sort).to eq(['job','name'])
    end
  end

  context "loading fixtures for cucumber scenarios" do
    it "loads the fixture for a scenario" do
      DataMagic.yml_directory = 'config/data'
      scenario = MockScenario.new([MockTag.new('@tag', 1), MockTag.new('@datamagic_user', 1)])
      expect(DataMagic).to receive(:load).with('user.yml')
      DataMagic.load_for_scenario scenario
    end

    it "uses the last fixture listed for a scenario if multiple exist" do
      scenario = MockScenario.new([MockTag.new('@fixture_default', 1), MockTag.new('@datamagic_user', 1)])
      expect(DataMagic).to receive(:load).with('user.yml')
      DataMagic.load_for_scenario scenario
    end

    it "allows you to force loading from a different folder without stepping on the global folder" do
      DataMagic.yml_directory = 'features'
      scenario = MockScenario.new([MockTag.new('@tag', 1), MockTag.new('@datamagic_user', 1)])
      expect(DataMagic).to receive(:load).with('user.yml')
      DataMagic.load_for_scenario scenario, 'config/data'
      expect(DataMagic.yml_directory).to eq('features')
    end
  end
end
