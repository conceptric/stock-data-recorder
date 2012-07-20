module Stock
  module Data
    class PriceList

      include Enumerable
      extend Forwardable
      def_delegators :@prices, :empty?, :size, :each
      
      def initialize()
        @prices = []
      end           
      
      def <<(price_data)                     
        @prices << QuotedPrice.new(price_data)
      end
            
    end
  end
end
