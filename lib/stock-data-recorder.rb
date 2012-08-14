require "stock-data-recorder/quoted_item"
require "stock-data-recorder/quoted_price"
require "stock-data-recorder/price_list"

require 'yahoo-api'
require 'csv'

module Stock
  module Data
    
    class Recorder
    
      @tickers = []     
      TARGETFILE = './quotes.csv'

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
        output_file = CSV.open(TARGETFILE, 'ab') 
        begin                                  
          get.each do |line|
            output_file << CSV::Row.new(line.keys, line.values)
          end                                     
        ensure
          output_file.close unless output_file.nil?
        end
      end
            
    end
    
  end
end
