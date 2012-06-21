require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe YahooApiQuery::Finance::Query do 
  shared_examples "successful queries" do |tickers|
    subject { YahooApiQuery::Finance::Query.new(tickers) }
    
    it "creates a new Yahoo API query" do
      subject.should be_true
    end

    it "returns a HTTP success response" do
      subject.response.should be_kind_of Net::HTTPSuccess
    end

    it "contains a single result" do
      subject.count.should == tickers.size
    end

    it "returns an array of quotes containing a single item" do
      subject.quotes.should be_instance_of Array
      subject.quotes.size.should == tickers.size
      subject.quotes.first['symbol'].should == tickers.first
    end

    it "the quote contains the correct data" do
      subject.quotes.first.should include 'quoted_at'
      subject.quotes.first.should include 'symbol'
      subject.quotes.first.should include 'Ask'
      subject.quotes.first.should include 'Bid'
    end        
  end
  
  context "of a valid single asset" do
    use_vcr_cassette "single_stock_query", :record => :new_episodes  
    include_examples "successful queries", ["BP.L"]
  end

  context "of two valid assets" do
    use_vcr_cassette "multi_stock_query", :record => :new_episodes
    let(:ticker) { ["BP.L", "BLT.L"] }  
    subject { YahooApiQuery::Finance::Query.new(ticker) }  

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