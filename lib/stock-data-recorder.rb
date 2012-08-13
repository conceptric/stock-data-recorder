require "stock-data-recorder/quoted_item"
require "stock-data-recorder/quoted_price"
require "stock-data-recorder/price_list"

module Stock
  module Data
    class Recorder
      @tickers = []

      def initialize(tickers)
        @tickers = tickers        
      end
                      
      def self.set_tickers(tickers)
      end
      
      def get
        quoted_items = []
        @tickers.each do |ticker| 
          quoted_items << Stock::Data::QuotedItem.new(ticker)
        end                
        quoted_items
      end    
      
      def write_to(io_string)       
        io_string << @tickers.join("\n")
        io_string
      end
    end
  end
end
