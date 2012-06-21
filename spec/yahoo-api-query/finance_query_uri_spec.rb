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
