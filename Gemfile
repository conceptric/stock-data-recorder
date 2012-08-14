source 'https://rubygems.org'

gem "rake"
gem "json"     
gem "yahoo-api", :git => "git://github.com/conceptric/yahoo-api.git"
gem "whenever", :require => false

group :development, :test do
  gem "rspec"
  gem "vcr"
  gem "webmock"
end

group :deployment do 
  gem 'capistrano', '2.12.0'
  gem 'rvm', '1.11.3.5'
  gem 'rvm-capistrano', '1.2.3'
end