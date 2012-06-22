require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe YahooApiQuery::Finance::QueryURI do 
  
  context "with a single ticker provided" do
    subject { YahooApiQuery::Finance::QueryURI.build(["BP.L"]) }

    it "returns a URI object for the Yahoo Finance Query" do
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
  
  context "with three tickers provided" do
    subject { YahooApiQuery::Finance::QueryURI.build(["BP.L","BLT.L","GSK.L"]) }

    it "should contain the correct query string" do
      subject.query.should == "q=select%20symbol,%20Ask,%20Bid%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22BP.L%22,%20%22BLT.L%22,%20%22GSK.L%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    end    
  end                                 
  
  context "without any tickers provided" do
    it "raises an exception with an empty ticker array" do
      expect {YahooApiQuery::Finance::QueryURI.build([])}. 
        to raise_error(ArgumentError, "At least one ticker must be supplied")
    end

    it "raises an exception with not ticker array" do
      expect {YahooApiQuery::Finance::QueryURI.build()}.
        to raise_error(ArgumentError, "wrong number of arguments (0 for 1)")
    end
  end
end
