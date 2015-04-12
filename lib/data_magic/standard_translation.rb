module DataMagic
  module StandardTranslation

    attr_reader :parent

    #
    # return a random name (first and last)
    #
    def full_name
      Faker::Name.name
    end
    alias_method :dm_full_name, :full_name

    #
    # return a random first name
    #
    def first_name
      Faker::Name.first_name
    end
    alias_method :dm_first_name, :first_name

    #
    # return a random last name
    #
    def last_name
      Faker::Name.last_name
    end
    alias_method :dm_last_name, :last_name

    #
    # return a random name prefix
    #
    def name_prefix
      Faker::Name.prefix
    end
    alias_method :dm_name_prefix, :name_prefix

    #
    # return a random name suffix
    #
    def name_suffix
      Faker::Name.suffix
    end
    alias_method :dm_name_suffix, :name_suffix

    #
    # return a random title
    #
    def title
      Faker::Name.title
    end
    alias_method :dm_title, :title

    #
    # return a random street address
    #
    def street_address(include_secondary=false)
      Faker::Address.street_address(include_secondary)
    end
    alias_method :dm_street_address, :street_address

    #
    # return a random secondary address
    #
    def secondary_address
      Faker::Address.secondary_address
    end
    alias_method :dm_secondary_address, :secondary_address

    #
    # return a random city
    #
    def city
      Faker::Address.city
    end
    alias_method :dm_city, :city

    #
    # return a random state
    #
    def state
      Faker::Address.state
    end
    alias_method :dm_state, :state

    #
    # return a random state abbreviation
    #
    def state_abbr
      Faker::Address.state_abbr
    end
    alias_method :dm_state_abbr, :state_abbr

    #
    # return a random 5 or 9 digit zip code
    #
    def zip_code
      Faker::Address.zip
    end
    alias_method :dm_zip_code, :zip_code

    #
    # return a random country
    #
    def country
      Faker::Address.country
    end
    alias_method :dm_country, :country


    #
    # return a random company name
    #
    def company_name
      Faker::Company.name
    end
    alias_method :dm_company_name, :company_name

    #
    # return a random catch phrase
    #
    def catch_phrase
      Faker::Company.catch_phrase
    end
    alias_method :dm_catch_phrase, :catch_phrase

    #
    # return a credit card number
    #
    def credit_card_number
      Faker::Business.credit_card_number
    end
    alias_method :dm_credit_card_number, :credit_card_number

    #
    # return a credit card type
    #
    def credit_card_type
      Faker::Business.credit_card_type
    end
    alias_method :dm_credit_card_type, :credit_card_type
    
    #
    # return random words - default is 3 words
    #
    def words(number = 3)
      Faker::Lorem.words(number).join(' ')
    end
    alias_method :dm_words, :words

    #
    # return a random sentence - default minimum word count is 4
    #
    def sentence(min_word_count = 4)
      Faker::Lorem.sentence(min_word_count)
    end
    alias_method :dm_sentence, :sentence

    #
    # return random sentences - default is 3 sentences
    #
    def sentences(sentence_count = 3)
      Faker::Lorem.sentences(sentence_count).join(' ')
    end
    alias_method :dm_sentences, :sentences

    #
    # return random paragraphs - default is 3 paragraphs
    #
    def paragraphs(paragraph_count = 3)
      Faker::Lorem.paragraphs(paragraph_count).join('\n\n')
    end
    alias_method :dm_paragraphs, :paragraphs

    #
    # return random characters - default is 255 characters
    #
    def characters(character_count = 255)
      Faker::Lorem.characters(character_count)
    end
    alias_method :dm_characters, :characters

    #
    # return a random email address
    #
    def email_address(name=nil)
      Faker::Internet.email(name)
    end
    alias_method :dm_email_address, :email_address

    #
    # return a random domain name
    #
    def domain_name
      Faker::Internet.domain_name
    end
    alias_method :dm_domain_name, :domain_name

    #
    # return a random url
    #
    def url
      Faker::Internet.url
    end
    alias_method :dm_url, :url

    #
    # return a random user name
    #
    def user_name
      Faker::Internet.user_name
    end
    alias_method :dm_user_name, :user_name

    #
    # return a random phone number
    #
    def phone_number
      value = Faker::PhoneNumber.phone_number
      remove_extension(value)
    end
    alias_method :dm_phone_number, :phone_number

    #
    # return a random cell number
    #
    def cell_phone
      value = Faker::PhoneNumber.cell_phone
      remove_extension(value)
    end
    alias_method :dm_cell_phone, :cell_phone

    #
    # return a random value from an array or range
    #
    def randomize(value)
      case value
      when Array then value[rand(value.size)]
      when Range then rand((value.last+1) - value.first) + value.first
      else value
      end
    end
    alias_method :dm_randomize, :randomize

    #
    # return an element from the array.  The first request will return
    # the first element, the second request will return the second,
    # and so forth.
    #
    def sequential(value)
      index = index_variable_for(value)
      index = (index ? index + 1 : 0)
      index = 0 if index == value.length
      set_index_variable(value, index)
      value[index]
    end

    #
    # return a value based on a mast
    # The # character will be replaced with a number
    # The A character will be replaced with an upper case letter
    # The a character will be replaced with a lower case letter
    #
    def mask(value)
      result = ''
      value.each_char do |ch|
        case ch
        when '#' then result += randomize(0..9).to_s
        when 'A' then result += ('A'..'Z').to_a[rand(26)]
        when 'a' then result += ('a'..'z').to_a[rand(26)]
        else result += ch
        end
      end
      result
    end
    alias_method :dm_mask, :mask



    private

    def set_index_variable(ary, value)
      index_hash[index_name(ary)] = value
    end

    def index_variable_for(ary)
      value = index_hash[index_name(ary)]
      index_hash[index_name(ary)] = -1 unless value
      index_hash[index_name(ary)]
    end

    def index_name(ary)
      "#{ary[0]}#{ary[1]}_index".gsub(' ', '_').downcase
    end

    def index_hash
      dh = data_hash[parent]
      data_hash[parent] = {} unless dh
      data_hash[parent]
    end

    def data_hash
      $data_magic_data_hash ||= {}
    end

    def process(value)
      eval value
    end

    def remove_extension(phone)
      index = phone.index('x')
      phone = phone[0, (index-1)] if index
      phone
    end
  end
end
