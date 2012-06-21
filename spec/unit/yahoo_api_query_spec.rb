require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Yahoo API Query" do
  
  context "of a valid single asset" do
    use_vcr_cassette "single_stock_query", :record => :new_episodes
    let(:ticker) { ["BP.L"] }  
    subject { YahooApiQuery::Finance::Query.new(ticker) }  

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