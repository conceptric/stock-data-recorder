# -*- encoding: utf-8 -*-
require File.expand_path('../lib/stock-data-recorder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["James Whinfrey"]
  gem.email         = ["james@conceptric.co.uk"]
  gem.description   = %q{Project to build a historical record of stock data for use in managing an investment portfolio by querying remote sources for data}
  gem.summary       = %q{Project to build a useful historical record of stock data from remote sources}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "stock-data-recorder"
  gem.require_paths = ["lib"]
  gem.version       = Stock::Data::Recorder::VERSION 
  
  gem.add_development_dependency('rspec')
  gem.add_dependency('rake')
  gem.add_dependency('json')  
end
