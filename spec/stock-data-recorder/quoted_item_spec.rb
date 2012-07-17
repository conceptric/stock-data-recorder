require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::QuotedItem do
  context "when created with valid attributes" do
    
    subject do
      Stock::Data::QuotedItem.new("BP.L")
    end
  
    it "creates an instance" do      
      subject.should be_instance_of Stock::Data::QuotedItem
    end                    

    it "has a ticker" do
      subject.ticker.should == "BP.L"
    end                          
  
  end
  
  context "when created with invalid attributes" do
    
    describe "raises an ArgumentError with invalid ticker types" do
      
      it "like a missing argument" do
        expect {Stock::Data::QuotedItem.new()}.to raise_error ArgumentError
      end
      
      it "like nil" do      
        invalid_ticker_helper(nil, "Ticker must be a valid string")
      end                    

      it "like an integer" do      
        invalid_ticker_helper(10, "Ticker must be a valid string")
      end                          

      it "like a boolean" do      
        invalid_ticker_helper(true, "Ticker must be a valid string")
      end                          
    
      it "like a blank string" do      
        invalid_ticker_helper("", "You must provide a ticker")
      end                        

      it "like a market string without a ticker" do      
        invalid_ticker_helper(".L", "You must provide a ticker")
      end                        
    
      it "like a ticker without a market string" do      
        invalid_ticker_helper("BP", "You must provide a market ID")
      end                        

    end    

  end

end