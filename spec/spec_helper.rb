require File.join(File.dirname(__FILE__), *%w[.. lib stock-data-recorder.rb])

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include QuotedItemMacros
end

