module Stock
  module Data
    class QuotedItem    

      extend Forwardable
      def_delegator :@prices, :each, :each_price
            
      attr_reader :ticker

      def initialize(ticker) 
        validate_ticker(ticker)
        @ticker = ticker    
        @prices = PriceList.new
      end

      def add_price(price_data)
        @prices << price_data
      end

      def has_prices?
        !@prices.empty?
      end        
      
      def number_of_prices
        @prices.size
      end           
      
      private

      def validate_ticker(ticker)
        raise ArgumentError, "Ticker must be a valid string", 
          caller unless ticker.class == String        
        raise ArgumentError, "You must provide a ticker", 
          caller if ticker !~ /^[a-zA-Z]+/
        raise ArgumentError, "You must provide a market ID", 
          caller if ticker !~ /\.[a-zA-Z]+$/
      end  
    end         
  end  
end
