# -*- encoding: utf-8 -*-
require File.expand_path('../lib/data_magic/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "data_magic"
  gem.version       = DataMagic::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Jeff Morgan"]
  gem.email         = ["jeff.morgan@leandog.com"]
  gem.license       = 'MIT'
  gem.homepage      = "http://github.com/cheezy/data_magic"
  gem.summary       = %q{Provides datasets to application via YAML files}
  gem.description   = %q{Provides datasets to application stored in YAML files}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 2.2'

  gem.add_dependency 'faker', '>= 1.1.2'
  gem.add_dependency 'yml_reader', '>= 0.6'

  gem.add_development_dependency 'rspec', '>= 2.12.0'
  gem.add_development_dependency 'cucumber', '>= 1.2.0'
end
