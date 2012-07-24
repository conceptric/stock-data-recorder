module Stock
  module Data
    class PriceList

      include Enumerable
      extend Forwardable
      def_delegators :@prices, :empty?, :size, :each, :clear
      
      def initialize()
        @prices = []
      end           
      
      def <<(price_data)                     
        @prices << QuotedPrice.new(price_data)
      end

      def delete_for_date(the_date)
        @prices.delete_if { |item| item.date == the_date }
      end
      
    end
  end
end
