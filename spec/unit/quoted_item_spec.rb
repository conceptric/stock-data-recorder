class QuotedItem    
  attr_reader :ticker
  
  def initialize(ticker) 
    validate_ticker(ticker)
    @ticker = ticker
  end
                        
  private
  
  def validate_ticker(ticker)
    unless ticker.class == String
      raise ArgumentError, "Ticker must be a valid string", caller
    end
    raise ArgumentError, "Ticker cannot be blank", caller if ticker == "" 
  end  
end         

describe QuotedItem do
  context "when created with valid attributes" do
    subject do
      QuotedItem.new("TEST.L")
    end
  
    it "creates an instance" do      
      subject.should be_instance_of QuotedItem
    end                    

    it "has a ticker" do
      subject.ticker.should == "TEST.L"
    end                          
  end
  
  context "when created with invalid attributes" do
    it "raises an ArgumentError when there are no attributes" do      
      expect {QuotedItem.new()}.to raise_error ArgumentError
    end                    
    
    describe "raises an ArgumentError with invalid ticker types" do
      def invalid_ticker_helper(ticker_type, message)
        expect {QuotedItem.new(ticker_type)}.to raise_error ArgumentError, 
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