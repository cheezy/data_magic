require 'spec_helper'

describe DataMagic do
  context "configuring the yml directory" do
    it "default to a directory named config" do
      DataMagic::Config.yml_directory.should == 'config'
    end
  end
end
