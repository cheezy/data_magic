require 'spec_helper'

describe DataMagic do
  context "configuring the yml directory" do
    it "should default to a directory named config" do
      DataMagic::Config.yml_directory.should == 'config'
    end

    it "should store a yml directory" do
      DataMagic::Config.yml_directory = 'test_dir'
      DataMagic::Config.yml_directory.should == 'test_dir'
    end
  end
end
