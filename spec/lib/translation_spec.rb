require 'spec_helper'

class TestSubject
  include DataMagic
end

describe "DataMagic translations" do
  context "when delivering data" do
    let(:example) { TestSubject.new }

    def set_field_value(value)
      DataMagic.should_receive(:yml).and_return({'key' => {'field' => value}})
    end
    
    it "should deliver the hash from the yaml" do
      set_field_value 'value'
      example.data_for('key').should have_field_value 'value'
    end

    context "translating random names" do
      it "should add a name" do
        Faker::Name.should_receive(:name).and_return('Joseph')
        set_field_value 'name'
        example.data_for('key').should have_field_value 'Joseph'
      end

      it "should add first name" do
        Faker::Name.should_receive(:first_name).and_return('Sam')
        set_field_value 'first_name'
        example.data_for('key').should have_field_value 'Sam'
      end

      it "should add last name" do
        Faker::Name.should_receive(:last_name).and_return('Smith')
        set_field_value 'last_name'
        example.data_for('key').should have_field_value 'Smith'
      end
    end

    context "translating random addresses" do
      it "should add a street address" do
        Faker::Address.should_receive(:street_address).and_return("123 Main")
        set_field_value 'street_address'
        example.data_for('key').should have_field_value '123 Main'
      end

      it "should add a city" do
        Faker::Address.should_receive(:city).and_return('Cleveland')
        set_field_value 'city'
        example.data_for('key').should have_field_value 'Cleveland'
      end

      it "should add a state" do
        Faker::Address.should_receive(:state).and_return('Ohio')
        set_field_value 'state'
        example.data_for('key').should have_field_value 'Ohio'
      end

      it "should add a state abbreviation" do
        Faker::Address.should_receive(:state_abbr).and_return('OH')
        set_field_value 'state_abbr'
        example.data_for('key').should have_field_value 'OH'
      end

      it "should add a zip code" do
        Faker::Address.should_receive(:zip_code).and_return('11111')
        set_field_value 'zip_code'
        example.data_for('key').should have_field_value '11111'
      end

      it "should add a country" do
        Faker::Address.should_receive(:country).and_return("United States")
        set_field_value 'country'
        example.data_for('key').should have_field_value 'United States'
      end

      it "should add a secondary address" do
        Faker::Address.should_receive(:secondary_address).and_return('2nd floor')
        set_field_value 'secondary_address'
        example.data_for('key').should have_field_value '2nd floor'
      end
    end

    context "translating company names" do
      it "should add a company name" do
        Faker::Company.should_receive(:name).and_return('LeanDog')
        set_field_value 'company_name'
        example.data_for('key').should have_field_value 'LeanDog'
      end
    end

    context "translating random phrases" do
      it "should add a catch phrase" do
        Faker::Company.should_receive(:catch_phrase).and_return('Ruby is cool')
        set_field_value 'catch_phrase'
        example.data_for('key').should have_field_value 'Ruby is cool'
      end

      it "should add random words" do
        Faker::Lorem.should_receive(:words).and_return(['random', 'words'])
        set_field_value 'words'
        example.data_for('key').should have_field_value 'random words'
      end

      it "should default to returning 3 words" do
        set_field_value 'words'
        example.data_for('key')['field'].split.size.should == 3
      end

      it "should allow you to specify the number of words" do
        set_field_value 'words(4)'
        example.data_for('key')['field'].split.size.should == 4
      end

      it "should add a random sentence" do
        Faker::Lorem.should_receive(:sentence).and_return('a sentence')
        set_field_value 'sentence'
        example.data_for('key').should have_field_value 'a sentence'
      end

      it "should default to returning a minimum of 4 words" do
        set_field_value 'sentence'
        example.data_for('key')['field'].split.size.should >= 4
      end

      it "should allow you to specify a minimum word count" do
        set_field_value 'sentence(20)'
        example.data_for('key')['field'].split.size.should >= 20
      end

      it "should add sentences" do
        Faker::Lorem.should_receive(:sentences).and_return(['this is sentences'])
        set_field_value 'sentences'
        example.data_for('key').should have_field_value 'this is sentences'
      end

      it "should default to returning a default of 3 sentences" do
        set_field_value 'sentences'
        example.data_for('key')['field'].split('.').size.should >= 3
      end

      it "should allow you to specify the number of  sentences" do
        set_field_value 'sentences(10)'
        example.data_for('key')['field'].split('.').size.should >= 10
      end

      it "should add a paragraphs" do
        Faker::Lorem.should_receive(:paragraphs).and_return(['this is a paragraph'])
        set_field_value 'paragraphs'
        example.data_for('key').should have_field_value 'this is a paragraph'
      end

      it "should return 3 paragraphs by default" do
        set_field_value 'paragraphs'
        example.data_for('key')['field'].split('\n\n').size.should == 3
      end

      it "should allow you to specify the number of paragraphs" do
        set_field_value 'paragraphs(10)'
        example.data_for('key')['field'].split('\n\n').size.should == 10
      end
    end
  end
end
