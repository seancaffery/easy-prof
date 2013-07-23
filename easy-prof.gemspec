# -*- encoding: utf-8 -*-
require File.expand_path('../lib/easy-prof/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sean Caffery"]
  gem.email         = ["sean.caffery@c3businesssolutions.com"]
  gem.description   = %q{easy prof}
  gem.summary       = %q{easy prof}
  gem.homepage      = ""

  gem.add_dependency('ruby-prof')

  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "easy-prof"
  gem.require_paths = ["lib"]
  gem.version       = EasyProf::VERSION
end
