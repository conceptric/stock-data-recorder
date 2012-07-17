require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::QuotedItem do 
  
  describe ".new instance of QuotedItem" do
    
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
         
      it "raises an error with a missing argument" do
        expect {Stock::Data::QuotedItem.new()}.to raise_error ArgumentError
      end
    
      it "raises an error with nil" do      
        invalid_ticker_helper(nil, "Ticker must be a valid string")
      end                    

      it "raises an error with an integer" do      
        invalid_ticker_helper(10, "Ticker must be a valid string")
      end                          

      it "raises an error with a boolean" do      
        invalid_ticker_helper(true, "Ticker must be a valid string")
      end                          
  
      it "raises an error with a blank string" do      
        invalid_ticker_helper("", "You must provide a ticker")
      end                        

      it "raises an error with a market id without a ticker" do      
        invalid_ticker_helper(".L", "You must provide a ticker")
      end                        
  
      it "raises an error with a ticker without a market id" do      
        invalid_ticker_helper("BP", "You must provide a market ID")
      end                        

    end
   
  end
  
end