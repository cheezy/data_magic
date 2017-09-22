# data_magic

[![Build Status](http://travis-ci.org/cheezy/data_magic.png)](http://travis-ci.org/cheezy/data_magic)

An easy to use gem that provides datasets that can be used by your application
and tests.  The data is stored in yaml files.

## Using

In order to use _data_magic_ you will have to inform the gem where it can find the yaml files.  You can do this with the following code:

````ruby
DataMagic.yml_directory = 'data/yml'
````

If you do not specify a directory the gem will default to using a directory named _config/data_. 

After setting the directory you must load a file.  This can be accomplished by calling the _load_ method.

````ruby
DataMagic.load 'filename.yml'
````

Another way to specify the file to load is to use a _tag_ in a cucumber scenario.  You tag should take the
form of `@datamagic_FILENAME` where `FILENAME` is replaced with the file you wish to load.  For example,
if you add the tag `@datamagic_foo` then the file `foo.yml` will be loaded.  If you want
to use the tags you simply have to add the following code in a hook:

````ruby
Before do |scenario|
  DataMagic.load_for_scenario(scenario)
end
````


If you do not specify a filename the gem will attempt to use a file named _default.yml_.  If you are using this for testing you will more than likely want to call load before each test to load the proper data for the specific test, or use the namespaced keys method, detailed below.

Another option is to set an environment variable DATA_MAGIC_FILE.  When this is set it will be used instead of the _default.yml_ file.

The final thing to do is use the data.  The gem has a `data_for` method that will return the data for a specific key.  The most common way to use this is to include the _DataMagic_ module in a [page-object](https://github.com/cheezy/page-object) and then populate a page with the data.  Here's an example:

````ruby
class MyPage
  include PageObject
  include DataMagic
  
  ...
  
  def populate_page
    populate_page_with data_for :my_page
  end
end
````

Notice that I am including the module on line 3.  On lin 8 I am calling the _data_for_ method passing the key _:my_page_.  The _populate_page_with_ method is a part of the page-object gem.

To organize your data into namespaces, and load that data just in time for testing, use namespaced keys instead:

````ruby
  page.populate_page_with data_for "user_form/valid"
````

This will load `user_form.yml`, and populate the page with the `valid:` record therein.

Your data might look something like this:

    my_page:
      name: Cheezy
      address: 123 Main Street
      email: cheezy@example.com
      pay_type: 'Credit card'

In order to access the data directly you can just call the method on the module like this:

````ruby
  page = MyPage.new
  my_data = page.data_for :my_test
````

## Data generators

You can call one of many built-in methods in your yaml file to randomize the data.  Here is an example of how you would randomize the above yaml:

    my_page:
      name: ~full_name
      address: ~street_address
      email: ~email_address
      pay_type: ~randomize ['Credit card', 'Purchase order', 'Check']

Here is a list of the built-in methods:

| built-in methods | built-in methods |
| --- | --- |
| first_name  last_name |
| last_name | full_name | 
| name_prefix | name_suffix | 
| title | street_address(include_secondary=false) |
| secondary_address | city |
| state | state_abbr |
| zip_code | country |
| company_name | catch_phrase |
| words(number = 3) | sentence(min_word_count = 4) |
| sentences(sentence_count = 3) | paragraphs(paragraph_count = 3) |
| characters(character_count = 255) | email_address(name = nil) | 
| domain_name | url | 
| user_name | 
| phone_number | cell_phone | 
| randomize([]) | randomize(1..4) | 
| mask -  #=num a=lower A=upper |
| today(format = '%D') | tomorrow(format = '%D') |
| yesterday(format = '%D') | 
| 3.days_from_today(format = '%D') | 3.days_ago(format = '%D') |
| month | month_abbr | 
| day_of_week | day_of_week_abbr |
| sequential([]) | sequential(1..4)|


If you wish to add your own built-in methods you can simply pass a module
to _DataMagic_ and all of the methods will be available.

````ruby
module MyData
  def abc
    'abc'
  end
end
   
DataMagic.add_translator MyData # this line must go in the same file as the module
    
# can now use ~abc in my yml files
````

## Documentation

The rdocs for this project can be found at [rubydoc.info](http://rubydoc.info/github/cheezy/data_magic/master/frames).

To see the changes from release to release please look at the [ChangeLog](https://raw.github.com/cheezy/data_magic/master/ChangeLog)

## Older versions of Ruby:

This gem only works with Ruby >= 2.2. Use versions 1.1 or below if you have an older Ruby.

## Known Issues

See [http://github.com/cheezy/data_magic/issues](http://github.com/cheezy/data_magic/issues)

## Contributing

Please ensure all contributions contain proper tests.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012-2013 Jeffrey S. Morgan. See LICENSE for details.
