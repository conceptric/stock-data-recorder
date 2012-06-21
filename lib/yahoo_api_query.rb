require 'json'

module YahooApiQuery
  API_QUERY_URL = "http://query.yahooapis.com/v1/public/yql?q="
  
  module Finance
    FINANCE_DATABASE = "yahoo.finance.quotes"
    DATATABLE = "&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    
    class Query                       
      attr_reader :response
      def initialize(tickers)
        @tickers = tickers                                   
        @response = Net::HTTP.get_response(URI(build_query_uri))
      end  

      def count
        parse_query_json['count']    
      end

      def quotes                                               
        add_datetime_to_quotes
      end

      private

      def build_query_uri
        base_query =  API_QUERY_URL + select_data_from + FINANCE_DATABASE + 
            for_these_symbols
        query = URI.encode(base_query) + "&format=json" + DATATABLE
      end     

      def for_these_symbols
        " where symbol in (\"#{@tickers.join("\", \"")}\")"    
      end
      
      def select_data_from
        "select symbol, Ask, Bid from "        
      end  
      
      def get_quotes_as_array 
        quote_data = parse_query_json['results']['quote']
        quote_data = [quote_data] unless quote_data.class == Array                
        quote_data
      end     
      
      def add_datetime_to_quotes
        get_quotes_as_array.each do |quote|
          quote['quoted_at']= parse_query_json['created']
        end              
      end 
      
      def parse_query_json
        JSON.parse(@response.body)['query']
      end
    end

  end
end
