require "stock-data-recorder/quoted_item"
require "stock-data-recorder/quoted_price"
require "stock-data-recorder/price_list"
require 'yahoo-api'

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
      
      def write_to(io_string)       
        io_string << get.join("\n")
        io_string
      end
    end
  end
end
