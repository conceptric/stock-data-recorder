#!/usr/bin/env rake
require 'rspec/core/rake_task'
require_relative 'lib/stock-data-recorder'

task :default => :core_spec
task :test => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new('spec') do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  # spec.rspec_opts = ['--backtrace']
end

desc "Run core specs"
RSpec::Core::RakeTask.new('core_spec') do |spec|
  spec.pattern = 'spec/**/*_recorder_spec.rb'
  # spec.rspec_opts = ['--backtrace']
end

desc "Poll for stock quotes"
task :poll_quotes do                          
  tickers = %w(BP.L GSK.L VOD.L RDSA.L ULVR.L BLT.L)
  recorder = Stock::Data::Recorder.new(tickers)
  recorder.write_to_csv
  puts "Quotes written for #{tickers}"
end