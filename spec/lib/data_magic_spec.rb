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

    context "translating random names" do
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

    context "translating random addresses" do
      it "should add a street address" do
        Faker::Address.should_receive(:street_address).and_return("123 Main")
        setup_data({'key' => {'field' => 'street_address'}})
        example.data_for('key').should == {'field' => '123 Main'}
      end

      it "should add a city" do
        Faker::Address.should_receive(:city).and_return('Cleveland')
        setup_data({'key' => {'field' => 'city'}})
        example.data_for('key').should == {'field' => 'Cleveland'}
      end

      it "should add a state" do
        Faker::Address.should_receive(:state).and_return('Ohio')
        setup_data({'key' => {'field' => 'state'}})
        example.data_for('key').should == {'field' => 'Ohio'}
      end

      it "should add a state abbreviation" do
        Faker::Address.should_receive(:state_abbr).and_return('OH')
        setup_data({'key' => {'field' => 'state_abbr'}})
        example.data_for('key').should == {'field' => 'OH'}
      end

      it "should add a zip code" do
        Faker::Address.should_receive(:zip_code).and_return('11111')
        setup_data({'key' => {'field' => 'zip_code'}})
        example.data_for('key').should == {'field' => '11111'}
      end

      it "should add a country" do
        Faker::Address.should_receive(:country).and_return("United States")
        setup_data({'key' => {'field' => 'country'}})
        example.data_for('key').should == {'field' => 'United States'}
      end
    end
  end
end
