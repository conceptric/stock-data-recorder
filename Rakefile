#!/usr/bin/env rake
require 'rspec/core/rake_task'

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