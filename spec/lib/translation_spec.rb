require 'spec_helper'
describe "DataMagic translations" do
  context "when delivering data" do
    let(:example) { (Class.new { include DataMagic }).new }

    def set_field_value(value)
      expect(DataMagic).to receive(:yml).twice.and_return({'key' => {'field' => value}})
    end

    it "should deliver the hash from the yaml" do
      set_field_value 'value'
      expect(example.data_for('key')).to have_field_value 'value'
    end

    it "should allow you to use a symbol for the key" do
      set_field_value 'value'
      expect(example.data_for(:key)).to have_field_value 'value'
    end

    it "should default to use a file named 'default.yml'" do
      hsh = double('hash')
      DataMagic.yml_directory = 'test'
      expect(File).to receive(:read).with("test/default.yml")
      expect(ERB).to receive(:new).and_return hsh
      expect(hsh).to receive(:result)
      expect(YAML).to receive(:load).and_return(test: 'test')
      expect(DataMagic).to receive(:yml).and_return(nil)
      expect(DataMagic).to receive(:yml).and_return({'key' => {'field' => 'value'}})
      expect(example.data_for('key')).to have_field_value 'value'
    end

    it "should clone the data returned so it can be resued" do
      yaml = double('yaml')
      expect(yaml).to receive(:merge).and_return(yaml)
      expect(DataMagic).to receive(:yml).twice.and_return(yaml)
      expect(yaml).to receive(:[]).and_return(yaml)
      expect(yaml).to receive(:deep_copy).and_return({'field' => 'value'})
      expect(example.data_for('key')).to have_field_value 'value'
    end

    it "should merge the provided data with the yaml data" do
      yaml = double('yaml')
      expect(DataMagic).to receive(:yml).twice.and_return(yaml)
      expect(yaml).to receive(:[]).and_return(yaml)
      expect(yaml).to receive(:merge).and_return(yaml)
      expect(yaml).to receive(:deep_copy).and_return({'field' => 'value'})
      expect(example.data_for('key')).to have_field_value 'value'
    end

    context "translating random names" do
      it "should add a name" do
        expect(Faker::Name).to receive(:name).and_return('Joseph')
        set_field_value '~full_name'
        expect(example.data_for('key')).to have_field_value 'Joseph'
      end

      it "should add first name" do
        expect(Faker::Name).to receive(:first_name).and_return('Sam')
        set_field_value '~first_name'
        expect(example.data_for('key')).to have_field_value 'Sam'
      end

      it "should add last name" do
        expect(Faker::Name).to receive(:last_name).and_return('Smith')
        set_field_value '~last_name'
        expect(example.data_for('key')).to have_field_value 'Smith'
      end

      it "should add name prefix" do
        expect(Faker::Name).to receive(:prefix).and_return("Mr")
        set_field_value '~name_prefix'
        expect(example.data_for('key')).to have_field_value 'Mr'
      end

      it "should add name suffix" do
        expect(Faker::Name).to receive(:suffix).and_return('Jr')
        set_field_value '~name_suffix'
        expect(example.data_for('key')).to have_field_value 'Jr'
      end
    end

    context "translating random addresses" do
      it "should add a street address" do
        expect(Faker::Address).to receive(:street_address).and_return("123 Main")
        set_field_value '~street_address'
        expect(example.data_for('key')).to have_field_value '123 Main'
      end

      it "should add a city" do
        expect(Faker::Address).to receive(:city).and_return('Cleveland')
        set_field_value '~city'
        expect(example.data_for('key')).to have_field_value 'Cleveland'
      end

      it "should add a state" do
        expect(Faker::Address).to receive(:state).and_return('Ohio')
        set_field_value '~state'
        expect(example.data_for('key')).to have_field_value 'Ohio'
      end

      it "should add a state abbreviation" do
        expect(Faker::Address).to receive(:state_abbr).and_return('OH')
        set_field_value '~state_abbr'
        expect(example.data_for('key')).to have_field_value 'OH'
      end

      it "should add a zip code" do
        expect(Faker::Address).to receive(:zip).and_return('11111')
        set_field_value '~zip_code'
        expect(example.data_for('key')).to have_field_value '11111'
      end

      it "should add a country" do
        expect(Faker::Address).to receive(:country).and_return("United States")
        set_field_value '~country'
        expect(example.data_for('key')).to have_field_value 'United States'
      end

      it "should add a secondary address" do
        expect(Faker::Address).to receive(:secondary_address).and_return('2nd floor')
        set_field_value '~secondary_address'
        expect(example.data_for('key')).to have_field_value '2nd floor'
      end
    end

    context "translating company names" do
      it "should add a company name" do
        expect(Faker::Company).to receive(:name).and_return('LeanDog')
        set_field_value '~company_name'
        expect(example.data_for('key')).to have_field_value 'LeanDog'
      end
    end

    context "translating business" do
      it "should add a credit card number" do
        expect(Faker::Business).to receive(:credit_card_number).and_return('123')
        set_field_value '~credit_card_number'
        expect(example.data_for('key')).to have_field_value '123'
      end

      it "should add credit card type" do
        expect(Faker::Business).to receive(:credit_card_type).
                   and_return('visa')
        set_field_value '~credit_card_type'
        expect(example.data_for('key')).to have_field_value 'visa'
      end
    end

    context "translating internet names" do
      it "should add an email address" do
        expect(Faker::Internet).to receive(:email).and_return('buddy@example.com')
        set_field_value '~email_address'
        expect(example.data_for('key')).to have_field_value 'buddy@example.com'
      end

      it "should add a domain name" do
        expect(Faker::Internet).to receive(:domain_name).and_return("google.com")
        set_field_value '~domain_name'
        expect(example.data_for('key')).to have_field_value 'google.com'
      end

      it "should add a user name" do
        expect(Faker::Internet).to receive(:user_name).and_return('very_cheezy')
        set_field_value '~user_name'
        expect(example.data_for('key')).to have_field_value 'very_cheezy'
      end
    end

    context "translating phone numbers" do
      it "shold add a phone number" do
        expect(Faker::PhoneNumber).to receive(:phone_number).and_return('555-555-5555')
        set_field_value '~phone_number'
        expect(example.data_for('key')).to have_field_value '555-555-5555'
      end
    end

    context "translating random phrases" do
      it "should add a catch phrase" do
        expect(Faker::Company).to receive(:catch_phrase).and_return('Ruby is cool')
        set_field_value '~catch_phrase'
        expect(example.data_for('key')).to have_field_value 'Ruby is cool'
      end

      it "should add random words" do
        expect(Faker::Lorem).to receive(:words).and_return(['random', 'words'])
        set_field_value '~words'
        expect(example.data_for('key')).to have_field_value 'random words'
      end

      it "should default to returning 3 words" do
        set_field_value '~words'
        expect(example.data_for('key')['field'].split.size).to eql 3
      end

      it "should allow you to specify the number of words" do
        set_field_value '~words(4)'
        expect(example.data_for('key')['field'].split.size).to eql 4
      end

      it "should add a random sentence" do
        expect(Faker::Lorem).to receive(:sentence).and_return('a sentence')
        set_field_value '~sentence'
        expect(example.data_for('key')).to have_field_value 'a sentence'
      end

      it "should default to returning a minimum of 4 words" do
        set_field_value '~sentence'
        expect(example.data_for('key')['field'].split.size).to be >= 4
      end

      it "should allow you to specify a minimum word count" do
        set_field_value '~sentence(20)'
        expect(example.data_for('key')['field'].split.size).to be >= 20
      end

      it "should add sentences" do
        expect(Faker::Lorem).to receive(:sentences).and_return(['this is sentences'])
        set_field_value '~sentences'
        expect(example.data_for('key')).to have_field_value 'this is sentences'
      end

      it "should default to returning a default of 3 sentences" do
        set_field_value '~sentences'
        expect(example.data_for('key')['field'].split('.').size).to be >= 3
      end

      it "should allow you to specify the number of  sentences" do
        set_field_value '~sentences(10)'
        expect(example.data_for('key')['field'].split('.').size).to be >= 10
      end

      it "should add a paragraphs" do
        expect(Faker::Lorem).to receive(:paragraphs).and_return(['this is a paragraph'])
        set_field_value '~paragraphs'
        expect(example.data_for('key')).to have_field_value 'this is a paragraph'
      end

      it "should return 3 paragraphs by default" do
        set_field_value '~paragraphs'
        expect(example.data_for('key')['field'].split('\n\n').size).to eql 3
      end

      it "should allow you to specify the number of paragraphs" do
        set_field_value '~paragraphs(10)'
        expect(example.data_for('key')['field'].split('\n\n').size).to eql 10
      end

      it "should add characters" do
        expect(Faker::Lorem).to receive(:characters).and_return('abcdefg')
        set_field_value '~characters'
        expect(example.data_for('key')).to have_field_value 'abcdefg'
      end
    end

    context "translating boolean values" do
      it "should resolve true" do
        set_field_value true
        expect(example.data_for('key')).to have_field_value true
      end

      it "should resolve false" do
        set_field_value false
        expect(example.data_for('key')).to have_field_value false
      end
    end

    context "with numeric values" do
      it "doesn't translate values" do
        set_field_value(1)
        expect(example.data_for("key")).to have_field_value 1
      end
    end

    context "with values not in the yaml" do
      it "throws a ArgumentError" do
        expect { example.data_for("inexistant_key") }.to raise_error ArgumentError
      end
    end

    context "providing date values" do
      it "should provide today's date" do
        set_field_value '~today'
        expect(example.data_for('key')).to have_field_value Date.today.strftime('%D')
      end

      it "should provide tomorrow's date" do
        set_field_value '~tomorrow'
        tomorrow = Date.today + 1
        expect(example.data_for('key')).to have_field_value tomorrow.strftime('%D')
      end

      it "should provide yesterday's date" do
        set_field_value '~yesterday'
        yesterday = Date.today - 1
        expect(example.data_for('key')).to have_field_value yesterday.strftime('%D')
      end

      it "should provide a date that is some number of days from now" do
        set_field_value '~5.days_from_today'
        the_date = Date.today + 5
        expect(example.data_for('key')).to have_field_value the_date.strftime('%D')
      end

      it "should provide a date that is some number of days ago" do
        set_field_value '~5.days_ago'
        the_date = Date.today - 5
        expect(example.data_for('key')).to have_field_value the_date.strftime('%D')
      end
    end
    context "should fail when translation call methos is not defined" do
      it "should fail if method does not exist" do
        set_field_value '~non_existing_method'
        expect{example.data_for('key')}.to raise_error(/non_existing_method/)
      end
    end

    context "array translation test" do
      it "should be able to translate " do
        set_field_value ["~'user' + 'name'", 'second']
        expect(example.data_for('key')).to have_field_value ['username','second']
      end
    end
  end
end
