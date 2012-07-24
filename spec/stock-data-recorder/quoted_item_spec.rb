require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::QuotedItem do 

  subject { Stock::Data::QuotedItem.new("BP.L") }
  
  describe ".new instance of QuotedItem" do
    
    context "with a valid ticker string" do      
      it { should be_instance_of Stock::Data::QuotedItem }
      its(:ticker) { should == "BP.L" }        
    end
  
    context "with no argument" do
      it { expect {Stock::Data::QuotedItem.new()}.to raise_error ArgumentError }
    end
    
    context "with the wrong argument type" do
      it { invalid_ticker_helper(nil, "Ticker must be a valid string") }
      it { invalid_ticker_helper(10, "Ticker must be a valid string") }
      it { invalid_ticker_helper(true, "Ticker must be a valid string") }
      it { invalid_ticker_helper([], "Ticker must be a valid string") }
      it { invalid_ticker_helper({}, "Ticker must be a valid string") }
      it { invalid_ticker_helper((1..10), "Ticker must be a valid string") }
    end
    
    context "with an invalid ticker string" do
      it { invalid_ticker_helper("", "You must provide a ticker") }
      it { invalid_ticker_helper(".L", "You must provide a ticker") }
      it { invalid_ticker_helper("BP", "You must provide a market ID") }
    end
   
  end

  describe "methods for handling asset prices" do
    
    let(:the_date)  { DateTime.new(2012,06,1) }
    let(:the_price) { { date:the_date, bid:1, ask:2 } }

    before(:each) do
      subject.add_price(the_price)
    end
    
    describe ".add_price" do
      
      it "adds a price data for the asset" do  
        subject.number_of_prices.should == 1
      end
  
    end
    
    describe ".number_of_prices" do

      it "returns the number of prices for the asset" do
        subject.number_of_prices.should == 1        
      end

    end
    
    describe ".delete_price()" do
    
      it "removes the price for the given datetime" do
        subject.delete_price(the_date)
        subject.number_of_prices.should == 0
      end                                         
    
    end

  end
  
end