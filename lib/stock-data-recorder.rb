require "stock-data-recorder/version"
require "stock-data-recorder/quoted_item"
require "stock-data-recorder/quoted_price"

module Stock
  module Data
    module Recorder
      def self.get(tickers)  
        quoted_items = []
        tickers.each do |ticker| 
          quoted_items << Stock::Data::QuotedItem.new(ticker)
        end                
        quoted_items
      end
    end
  end
end
