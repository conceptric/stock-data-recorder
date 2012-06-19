require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'json'

describe "Yahoo API Query" do
  
  use_vcr_cassette "single_stock_query", :record => :new_episodes
  let(:target_uri) { 
URI('http://query.yahooapis.com/v1/public/yql?q=select%20symbol%2C%20Ask%2C%20Bid%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22BP.L%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys')  }  

  before(:each) do  
    response = Net::HTTP.get_response(target_uri)
    @result = JSON.parse(response.body)
  end       
  
  it "gets an HTTP response" do
    Net::HTTP.get_response(target_uri).should be_instance_of Net::HTTPOK
  end

  it "returns the result of the query as JSON" do     
    @result.should be_instance_of Hash
    @result['query'].should be_true
  end

  it "contains a single result" do
    @result['query']['count'] == 1
  end

  it "the result is in a Hash of results" do
    @result['query']['results'].should be_instance_of Hash    
  end
  
end