module DataMagic
  module DateTranslation
    #
    # return today's date
    #
    # @param String the format to use for the date.  Default is %D
    #
    # See http://ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#method-i-strftime
    # for details of the formats
    #
    def today(format = '%D')
      Date.today.strftime(format)
    end
    alias_method :dm_today, :today

    #
    # return tomorrow's date
    #
    # @param String the format to use for the date.  Default is %D
    #
    # See http://ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#method-i-strftime
    # for details of the formats
    #
    def tomorrow(format = '%D')
      tomorrow = Date.today + 1
      tomorrow.strftime(format)
    end
    alias_method :dm_tomorrow, :tomorrow

    #
    # return yesterday's date
    #
    # @param String the format to use for the date.  Default is %D
    #
    # See http://ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#method-i-strftime
    # for details of the formats
    #
    def yesterday(format = '%D')
      yesterday = Date.today - 1
      yesterday.strftime(format)
    end
    alias_method :dm_yesterday, :yesterday

    #
    # return a month
    #
    def month
      randomize(Date::MONTHNAMES[1..-1])
    end
    alias_method :dm_month, :month

    #
    # return a month abbreviation
    #
    def month_abbr
      randomize(Date::ABBR_MONTHNAMES[1..-1])
    end
    alias_method :dm_month_abbr, :month_abbr

    #
    # return a day of the week
    #
    def day_of_week
      randomize(Date::DAYNAMES)
    end
    alias_method :dm_day_of_week, :day_of_week

    def day_of_week_abbr
      randomize(Date::ABBR_DAYNAMES)
    end
    alias_method :dm_day_of_week_abbr, :day_of_week_abbr
  end
end
