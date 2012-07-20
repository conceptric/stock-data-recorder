module Stock
  module Data
    class PriceList

      include Enumerable
      extend Forwardable
      def_delegators :@prices, :empty?, :size, :each
      
      def initialize()
        @prices = []
      end           
      
      def <<(price)     
        @prices << price if price.class == Stock::Data::QuotedPrice
      end
      
    end
  end
end
