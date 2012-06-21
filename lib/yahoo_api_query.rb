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
        JSON.parse(@response.body)['query']['count']    
      end

      def quotes                                               
        quote_data = JSON.parse(@response.body)['query']['results']['quote']        
        quote_data = [quote_data] if count == 1
        quote_data.each do |quote|
          quote['quoted_at']= JSON.parse(@response.body)['query']['created']
        end      
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
    end

  end
end
