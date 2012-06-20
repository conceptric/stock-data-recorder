require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'json'

class YahooApiQuery                       
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
    datatable = "&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    base_query =  "http://query.yahooapis.com/v1/public/yql?" +  
        "q=select symbol, Ask, Bid from yahoo.finance.quotes " + 
        "where symbol in (#{parse_tickers})&format=json"
    query = URI.encode(base_query) + datatable
  end     

  def parse_tickers
    "\"#{@tickers.join("\", \"")}\""    
  end
  
end

describe "Yahoo API Query" do
    
  context "of a valid single asset" do

    use_vcr_cassette "single_stock_query", :record => :new_episodes
    let(:ticker) { ["BP.L"] }  
    subject { YahooApiQuery.new(ticker) }  

    it "creates a new Yahoo API query" do
      subject.should be_true
    end
    
    it "returns a HTTP success response" do
      subject.response.should be_kind_of Net::HTTPSuccess
    end

    it "contains a single result" do
      subject.count.should == 1
    end

    it "returns an array of quotes containing a single item" do
      subject.quotes.should be_instance_of Array
      subject.quotes.size.should == 1
      subject.quotes.first['symbol'].should == 'BP.L'
    end

    it "the quote contains the correct data" do
      subject.quotes.first.should include 'quoted_at'
      subject.quotes.first.should include 'symbol'
      subject.quotes.first.should include 'Ask'
      subject.quotes.first.should include 'Bid'
    end
    
  end

  context "of two valid assets" do

    use_vcr_cassette "multi_stock_query", :record => :new_episodes
    let(:ticker) { ["BP.L", "BLT.L"] }  
    subject { YahooApiQuery.new(ticker) }  

    it "creates a new Yahoo API query" do
      subject.should be_true
    end

    it "returns a HTTP success response" do
      subject.response.should be_kind_of Net::HTTPSuccess
    end

    it "contains two results" do
      subject.count.should == 2
    end
    
    it "returns an array of quotes containing two items" do
      subject.quotes.should be_instance_of Array
      subject.quotes.size.should == 2
      subject.quotes.first['symbol'].should == 'BP.L'
      subject.quotes.last['symbol'].should == 'BLT.L'
    end
    
  end
  
end