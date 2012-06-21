require 'json'

module YahooApiQuery
  API_QUERY_URL = "http://query.yahooapis.com/v1/public/yql?q="
  
  module Finance
    FINANCE_DATABASE = "yahoo.finance.quotes"
    
    class Query                       
      attr_reader :response
      def initialize(tickers)
        @tickers = tickers                                   
        uri = URI(build_query_uri(tickers))  
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

      def build_query_uri(tickers)                                      
        data_to_select = "select symbol, Ask, Bid from "
        for_these_symbols = " where symbol in (#{parse_tickers})"
        datatable = "&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        base_query =  API_QUERY_URL + data_to_select + FINANCE_DATABASE + 
            for_these_symbols + "&format=json"
        query = URI.encode(base_query) + datatable
      end     

      def parse_tickers
        "\"#{@tickers.join("\", \"")}\""    
      end
    end

  end
end
