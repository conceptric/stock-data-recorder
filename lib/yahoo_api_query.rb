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
        uri = URI(build_query_uri)  
        @response = Net::HTTP.get_response(uri)
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
        select_data_from = "select symbol, Ask, Bid from "
        for_these_symbols = " where symbol in (#{parse_tickers})"
        base_query =  API_QUERY_URL + select_data_from + FINANCE_DATABASE + 
            for_these_symbols
        query = URI.encode(base_query) + "&format=json" + DATATABLE
      end     

      def parse_tickers
        "\"#{@tickers.join("\", \"")}\""    
      end
    end

  end
end
