require "stock-data-recorder/quoted_item"
require "stock-data-recorder/quoted_price"
require "stock-data-recorder/price_list"
require 'yahoo-api'
require 'csv'

module Stock
  module Data
    
    class Recorder
    
      @tickers = []

      def initialize(tickers)
        @tickers = tickers        
      end
                      
      def get
        begin
          return Yahoo::Api::Finance::Query.new(@tickers).quotes
        rescue ArgumentError
          return []
        end
      end    
      
      def write_to_csv                                     
        get.each do |line|
          CSV.open('./test.csv') << CSV::Row.new(line.keys, line.values)
        end
      end
            
    end
    
  end
end
