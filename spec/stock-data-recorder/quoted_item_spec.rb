require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::QuotedItem do
  context "when created with valid attributes" do
    subject do
      Stock::Data::QuotedItem.new("TEST.L")
    end
  
    it "creates an instance" do      
      subject.should be_instance_of Stock::Data::QuotedItem
    end                    

    it "has a ticker" do
      subject.ticker.should == "TEST.L"
    end                          
  end
  
  context "when created with invalid attributes" do
    it "raises an ArgumentError when there are no attributes" do      
      expect {Stock::Data::QuotedItem.new()}.to raise_error ArgumentError
    end                    
    
    describe "raises an ArgumentError with invalid ticker types" do
      def invalid_ticker_helper(ticker_type, message)
        expect {Stock::Data::QuotedItem.new(ticker_type)}.
        to raise_error ArgumentError, 
          message        
      end

      it "like nil" do      
        invalid_ticker_helper(nil, "Ticker must be a valid string")
      end                    

      it "like an integer" do      
        invalid_ticker_helper(10, "Ticker must be a valid string")
      end                          
    
      it "like a blank string" do      
        invalid_ticker_helper("", "Ticker cannot be blank")
      end                        
    end    
  end
end