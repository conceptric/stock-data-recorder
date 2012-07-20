module Stock
  module Data
    class QuotedPrice
      include Comparable
      
      attr_reader :date, :bid, :ask

      def initialize(args)                              
        validate(args)
        @date = args[:date]
        @bid = args[:bid]
        @ask = args[:ask]
      end
      
      def <=>(another)
        date <=> another.date
      end

      def spread
        ask - bid
      end                                           
      
      private 

      def validate(args)
        if args.class != Hash
          raise ArgumentError, 'Price data must be a hash'
        end
        if args.empty? || !args[:date] || !args[:ask] || !args[:bid]
          raise ArgumentError, 'The price data are incomplete'
        end        
      end
      
    end    
  end  
end
