module DataMagic
  module Translation
    def name
      Faker::Name.name
    end

    def first_name
      Faker::Name.first_name
    end

    def last_name
      Faker::Name.last_name
    end

  end
end
