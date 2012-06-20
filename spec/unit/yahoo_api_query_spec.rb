require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'json'

class YahooApiQuery                       
  attr_reader :response
  def initialize(ticker)                                   
    uri = URI(build_query_uri(ticker))  
    @response = Net::HTTP.get_response(uri)
  end  

  def count
    JSON.parse(@response.body)['query']['count']    
  end

  def data
    JSON.parse(@response.body)['query']['results']        
  end

  private
  
  def build_query_uri(ticker)                                      
    datatable = "&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    base_query =  "http://query.yahooapis.com/v1/public/yql?" +  
        "q=select symbol, Ask, Bid from yahoo.finance.quotes " + 
        "where symbol in (\"#{ticker}\")&format=json"
    query = URI.encode(base_query) + datatable
  end
end

describe "Yahoo API Query" do
    
  context "of an valid single asset" do

    use_vcr_cassette "single_stock_query", :record => :new_episodes
    let(:ticker) { "BP.L" }  
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

    it "returns a Hash of results with a single quote item" do
      subject.data.should be_instance_of Hash
      subject.data.size.should == 1
      subject.data.should include 'quote'
    end
    
  end
  
end