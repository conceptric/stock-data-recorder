require "stock-data-recorder/version"
require "stock-data-recorder/quoted_item"
require "stock-data-recorder/quoted_price"
require "stock-data-recorder/price_list"

module Stock
  module Data
    module Recorder
      @@tickers = []
                      
      def self.set_tickers(tickers)
        @@tickers = tickers
      end
      
      def self.get
        quoted_items = []
        @@tickers.each do |ticker| 
          quoted_items << Stock::Data::QuotedItem.new(ticker)
        end                
        quoted_items
      end    
      
      def self.write_to(io_string)
        io_string << @@tickers.join(',')
      end
    end
  end
end
