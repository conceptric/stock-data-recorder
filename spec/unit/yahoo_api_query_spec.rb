require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe YahooApiQuery::Finance::QueryURI do 
  subject { YahooApiQuery::Finance::QueryURI.build(["BP.L"]) }
  
  it "Returns a URI object for the Yahoo Finance Query" do
    subject.should be_instance_of URI::HTTP 
  end
  
  it "should be a URL to the Yahoo API" do
    subject.scheme.should == "http"    
    subject.host.should == "query.yahooapis.com"
    subject.path.should == "/v1/public/yql"
  end

  it "should contain the correct query string" do
    subject.query.should == "q=select%20symbol,%20Ask,%20Bid%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22BP.L%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
  end
  
  it "should parse the correct URL string" do
    expected = "http://query.yahooapis.com/v1/public/yql?q=select%20symbol,%20Ask,%20Bid%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22BP.L%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    subject.to_s.should == expected
  end
end

describe YahooApiQuery::Finance::Query do 
  shared_examples "successful queries" do |tickers|
    subject { YahooApiQuery::Finance::Query.new(tickers) }
    
    it "creates a new Yahoo API query" do
      subject.should be_true
    end

    it "returns a HTTP success response" do
      subject.response.should be_kind_of Net::HTTPSuccess
    end

    it "reports #{tickers.size} results" do
      subject.count.should == tickers.size
    end

    it "returns an array of #{tickers.size} quotes" do
      subject.quotes.should be_instance_of Array
      subject.quotes.size.should == tickers.size
    end

    it "the quotes contain the requested data" do
      subject.quotes.each do |quote|
        quote.should include 'quoted_at'
        quote.should include 'symbol'
        quote.should include 'Ask'
        quote.should include 'Bid'        
      end
    end        
  end
  
  context "of a valid single asset" do
    use_vcr_cassette "single_stock_query", :record => :new_episodes  
    include_examples "successful queries", ["BP.L"]

    it "the quote is for the requested ticker" do
      subject.quotes.first['symbol'].should == 'BP.L'
    end    
  end

  context "of two valid assets" do
    use_vcr_cassette "multi_stock_query", :record => :new_episodes
    include_examples "successful queries", ["BP.L", "BLT.L"]

    it "the quotes are for the requested tickers" do
      subject.quotes.first['symbol'].should == 'BP.L'
      subject.quotes.last['symbol'].should == 'BLT.L'
    end    
  end      
end