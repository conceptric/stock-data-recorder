module Stock
  module Data
    class QuotedPrice
      include Comparable
      
      attr_reader :date, :bid, :ask

      def initialize(date, ask, bid)
        @date = date
        @bid = bid
        @ask = ask
      end
      
      def <=>(another)
        date <=> another.date
      end

      def spread
        ask - bid
      end
    end    
  end  
end
