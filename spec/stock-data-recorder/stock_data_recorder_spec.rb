require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::Recorder do

  let(:tickers) { %w(BP.L GSK.L) }             

  after(:each) do
    Stock::Data::Recorder.set_tickers([])        
  end
    
  describe ".get" do                            
    
    subject { Stock::Data::Recorder.get }
    
    context "with no tickers defined" do
      it "returns an empty collection" do
        subject.should be_empty
      end
    end                             
    
    context "with tickers defined" do        
      before(:each) do
        Stock::Data::Recorder.set_tickers(tickers)        
      end

      it "returns a collection with an entry for each ticker" do
        subject.size.should eql tickers.size
      end                 

      it "the first entry for the first ticker" do
        subject.first.ticker.should eql tickers.first
      end      

      it "the last entry for the last ticker" do
        subject.last.ticker.should eql tickers.last
      end      
    end
  
  end                                                

  describe ".write_to" do
    
    subject { Stock::Data::Recorder.write_to(StringIO.new) }
    
    context "with no tickers defined" do    
      it "returns an empty StringIO" do
        subject.string.should eql ""
      end                                             
    end

    context "with tickers defined" do
      it "returns a StringIO containing the tickers" do
        Stock::Data::Recorder.set_tickers(tickers)
        subject.string.should eql tickers.join(',')
      end    
    end
    
  end
  
end