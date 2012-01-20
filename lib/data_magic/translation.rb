module DataMagic
  module Translation
    #
    # return a random name (first and last)
    #
    def name
      Faker::Name.name
    end

    #
    # return a random first name
    #
    def first_name
      Faker::Name.first_name
    end

    #
    # return a random last name
    #
    def last_name
      Faker::Name.last_name
    end

    #
    # return a random street address
    #
    def street_address
      Faker::Address.street_address
    end

    #
    # return a random city
    #
    def city
      Faker::Address.city
    end

    #
    # return a random state
    #
    def state
      Faker::Address.state
    end

    #
    # return a random state abbreviation
    #
    def state_abbr
      Faker::Address.state_abbr
    end

    #
    # return a random zip code
    #
    def zip_code
      Faker::Address.zip_code
    end

    #
    # return a random country
    #
    def country
      Faker::Address.country
    end
  end
end
