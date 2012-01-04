# -*- encoding: utf-8 -*-
require File.expand_path('../lib/data_magic/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "data_magic"
  gem.version       = DataMagic::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Jeff Morgan"]
  gem.email         = ["jeff.morgan@leandog.com"]
  gem.homepage      = "http://github.com/cheezy/data_magic"
  gem.summary       = %q{Provides datasets to application via YAML files}
  gem.description   = %q{Provides datasets to application stored in YAML files}
  
  gem.rubyforge_project = "data_magic"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'faker', '>= 1.0.1'

  gem.add_development_dependency 'rspec', '>= 2.6.0'
  gem.add_development_dependency 'cucumber', '>= 1.1.0'
end
