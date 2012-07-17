require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::Recorder do

  let(:tickers) { %w(BP.L GSK.L) }

  describe ".get method" do                            
    
    subject { Stock::Data::Recorder.get(tickers) }
    
    it "requires an array of ticker strings" do
      expect { subject }.not_to raise_error
    end                                                               
    
    it "returns an array with an entry for each ticker" do
      subject.should be_instance_of Array
      subject.size.should == 2
    end                 

    it "each entry is a instance of quoted item" do
      subject.each do |quoted_item|
        quoted_item.should be_instance_of Stock::Data::QuotedItem
      end
    end
    
    it "each quoted item corresponds to a ticker" do
      quoted_tickers = []
      subject.each do |quoted_item|
        quoted_tickers << quoted_item.ticker
      end                        
      quoted_tickers.should == tickers
    end

    it "each quoted item contains a single price" do
    end

    it "each price is an instance of quoted price" do      
    end
  
  end                                                
  
  describe ".save method" do

    it "serialised the Quotes to a text file as comman delimited data" do      
    end

  end

end