require 'spec_helper'

describe DataMagic do
  context "when configuring the yml directory" do
    before(:each) do
      DataMagic.yml_directory = nil
    end
    
    it "should default to a directory named config" do
      DataMagic.yml_directory.should == 'config/data'
    end

    it "should store a yml directory" do
      DataMagic.yml_directory = 'test_dir'
      DataMagic.yml_directory.should == 'test_dir'
    end
  end

  context "when reading yml files" do
    it "should read files from the config directory" do
      DataMagic.yml_directory = 'test'
      YAML.should_receive(:load_file).with("test/fname").and_return({})
      DataMagic.load("fname")
    end
  end

  context "namespaced keys" do
    it "loads correct file and retrieves data" do
      DataMagic.yml_directory = 'config/data'
      class UserPage
        include DataMagic
      end
      data = UserPage.new.data_for "user/valid"
      expect(data.keys.sort).to eq(['job','name'])
    end
  end
end
