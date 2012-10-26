# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mastar/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["pinzolo"]
  gem.email         = ["pinzolo@gmail.com"]
  gem.description   = %q{MASTer table on Active Record}
  gem.summary       = %q{add some features to master table class on ActiveRecord}
  gem.homepage      = "https://github.com/pinzolo/mastar"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mastar"
  gem.require_paths = ["lib"]
  gem.version       = Mastar::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rdoc'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'activerecord'
end
