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

      def delete_price(for_date)
        @prices.clear
      end

      def number_of_prices
        @prices.size
      end           
      
      def to_csv
        output = []
        @prices.each do |price|
          output << "#{ticker},#{price.to_csv}"
        end                           
        output.join("\n")
      end       
      
      def validate_ticker(ticker)
        raise ArgumentError, "Ticker must be a valid string", 
          caller unless ticker.class == String        
        raise ArgumentError, "You must provide a ticker", 
          caller if ticker !~ /^[a-zA-Z]+/
        raise ArgumentError, "You must provide a market ID", 
          caller if ticker !~ /\.[a-zA-Z]+$/
      end  

      private :validate_ticker

    end         
  end  
end
