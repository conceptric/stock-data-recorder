require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::Recorder do

  let(:tickers) { %w(BP.L GSK.L) }

  describe ".get method" do                            
    
    subject { Stock::Data::Recorder.get(tickers) }
    
    it "returns a collection with an entry for each ticker" do
      subject.size.should == tickers.size
    end                 
    
    it "there is one entry for each ticker" do
      quoted_tickers = []
      subject.each do |entry|
        quoted_tickers << entry.ticker
      end                        
      quoted_tickers.should == tickers
    end
  
  end                                                
  
end