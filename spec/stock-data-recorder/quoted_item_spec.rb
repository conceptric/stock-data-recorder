require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::QuotedItem do 

  subject { Stock::Data::QuotedItem.new("BP.L") }
  
  describe ".new instance of QuotedItem" do
    
    context "when created with valid attributes" do
      
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
  
  describe ".add_price" do
    
    let(:oldest)  { DateTime.new(2012,01,1) }
    let(:old)     { DateTime.new(2012,04,1) }
    let(:new)     { DateTime.new(2012,06,1) }
    let(:oldest_price)  { { date:oldest , bid:1, ask:2 } }
    let(:old_price)     { { date:old    , bid:1, ask:2 } }
    let(:new_price)     { { date:new    , bid:1, ask:2 } }
    
    context "with an empty price list" do

      it "has no prices" do
        subject.has_prices?.should be_false
      end                       
    
      it "adds price data based on a hash" do  
        subject.add_price(old_price)
        subject.number_of_prices.should == 1
        subject.each_price do |price|       
          price.bid == 1
          price.ask == 2
        end
      end

      it "the price can tell me the spread" do              
        subject.add_price(old_price)
        subject.each_price do |price|
          price.spread == 1
        end
      end

    end
    
    context "with an existing entry in the price list" do
      
      before(:each) do
        subject.add_price(old_price)
      end
      
      it "has a single price" do
        subject.number_of_prices.should == 1                    
      end                                                            
      
      it "adds a second price" do
        subject.add_price(old_price)
        subject.number_of_prices.should == 2
      end                                     
      
    end           

  end

end