module Stock
  module Data
    class QuotedItem    
      attr_reader :ticker, :prices

      def initialize(ticker) 
        validate_ticker(ticker)
        @ticker = ticker    
        @prices = []
      end

      def add_price(price_data)
        @prices << QuotedPrice.new(
                    price_data[:date], 
                    price_data[:ask],
                    price_data[:bid])
        @prices = @prices.sort.reverse
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
