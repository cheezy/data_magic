require 'spec_helper'

class UserPage
  include DataMagic
end

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
      File.should_receive(:read).with("test/fname").and_return('test')
      DataMagic.load("fname")
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
  end

  context "namespaced keys" do
    it "loads correct file and retrieves data" do
      DataMagic.yml_directory = 'config/data'
      data = UserPage.new.data_for "user/valid"
      expect(data.keys.sort).to eq(['job','name'])
    end
  end
end
