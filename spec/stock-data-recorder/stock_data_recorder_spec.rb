require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::Recorder do

  let(:tickers) { %w(BP.L GSK.L) }        
  
  describe ".get" do                            
    
    context "with no tickers defined" do
      it "returns an empty collection" do        
        Stock::Data::Recorder.new([]).get.should be_empty
      end
    end                             
    
    context "with tickers defined" do        
      subject { Stock::Data::Recorder.new(tickers)}     

      it "returns a collection with an entry for each ticker" do
        subject.get.size.should eql tickers.size
      end                 

      it "the first entry for the first ticker" do
        subject.get.first.ticker.should eql tickers.first
      end      

      it "the last entry for the last ticker" do
        subject.get.last.ticker.should eql tickers.last
      end      
    end
  
  end                                                

  describe ".write_to" do
    
    subject { Stock::Data::Recorder.new(tickers).write_to(StringIO.new) }
    
    context "with no tickers defined" do    
      it "returns an empty StringIO" do
        recorder = Stock::Data::Recorder.new([]).write_to(StringIO.new)
        recorder.string.should eql ""
      end                                             
    end

    context "with tickers defined" do
      it "returns a StringIO containing the tickers" do
        tickers.each do |ticker|
          subject.string.should include ticker
        end
      end                                     
      
      it "returns a StringIO with a single line for each ticker" do
        subject.rewind
        subject.readlines.size.should eql 2
      end
    end
    
  end
  
end