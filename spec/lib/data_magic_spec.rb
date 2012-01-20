require 'spec_helper'

class TestSubject
  include DataMagic
end

describe DataMagic do
  context "when configuring the yml directory" do
    it "should default to a directory named config" do
      DataMagic::Config.yml_directory.should == 'config'
    end

    it "should store a yml directory" do
      DataMagic::Config.yml_directory = 'test_dir'
      DataMagic::Config.yml_directory.should == 'test_dir'
    end
  end

  context "when reading yml files" do
    it "should read files from the config directory" do
      DataMagic::Config.yml_directory = 'test'
      YAML.should_receive(:load_file).with("test/fname").and_return({})
      DataMagic.load("fname")
    end
  end

  context "when delivering data" do
    let(:example) { TestSubject.new }

    def setup_data(data)
      DataMagic.should_receive(:yml).and_return(data)
    end
    
    it "should deliver the hash from the yaml" do
      setup_data({'key' => {'field' => 'value'}})
      example.data_for('key').should == {'field' => 'value'}
    end

    it "should add a name" do
      Faker::Name.should_receive(:name).and_return('Joseph')
      setup_data({'key' => {'field' => 'name'}})
      example.data_for('key').should == {'field' => 'Joseph'}
    end

    it "should add first name" do
      Faker::Name.should_receive(:first_name).and_return('Sam')
      setup_data({'key' => {'field' => 'first_name'}})
      example.data_for('key').should == {'field' => 'Sam'}
    end

    it "should add last name" do
      Faker::Name.should_receive(:last_name).and_return('Smith')
      setup_data({'key' => {'field' => 'last_name'}})
      example.data_for('key').should == {'field' => 'Smith'}
    end
  end
end
