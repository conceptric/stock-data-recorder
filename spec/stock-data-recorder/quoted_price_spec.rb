require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::QuotedPrice do              

  let(:price_date) { DateTime.new(2012,05,31) }
  let(:ask_price) { 100.0 }
  let(:bid_price) { 100.0 }

  context "with valid hash data" do

    let(:valid_data) { {date:price_date, ask:ask_price, bid:bid_price} }
  
    subject do
      Stock::Data::QuotedPrice.new(valid_data)
    end            
  
    its(:date) { should be_instance_of DateTime }
  
    it "returns the date when asked" do
      subject.date.should == price_date
    end

    it "returns the currency in which the prices are quoted"
    it "belongs to a quoted security identified by ticker"
  
    shared_examples "a set of quoted prices" do 
      it "include the bid price" do
        subject.bid.should == bid_price
      end

      it "include the asking price" do
        subject.ask.should == ask_price
      end                          

      it "calculated spread between the two prices" do
        subject.spread.should == ask_price - bid_price
      end                
    end            
  
    context "with matching prices" do
      it_behaves_like "a set of quoted prices"
    end
  
    context "with different prices" do
      let(:bid_price) { 100.0 }
      it_behaves_like "a set of quoted prices"
    end
  
    describe "are comparable" do
                                     
      let(:valid_past_data) { {date:DateTime.new(2012,01,01), 
        ask:ask_price, bid:bid_price} }
      let(:past) { Stock::Data::QuotedPrice.new(valid_past_data) } 

      let(:valid_recent_data) { {date:DateTime.new(2012,06,01), ask:ask_price, bid:bid_price} }
      let(:recent) { Stock::Data::QuotedPrice.new(valid_recent_data) }
        
      it "can tell when two prices are of the same date" do
        same = Stock::Data::QuotedPrice.new(valid_data)
        subject.should == same
      end
    
      it "can tell when one price is newer than another" do      
        subject.should > past
      end                                         
    
      it "can tell when one price is older than another" do
        subject.should < recent      
      end
    
    end
    
  end

  context "without a hash argument" do
    
    let(:invalid_types) { [1, 1.0, '1', true, [1]] }
    
    it "throws an ArgumentError" do
      invalid_types.each do |invalid_type|
        expect { Stock::Data::QuotedPrice.new(invalid_type) }.
          to raise_error, ArgumentError      
      end
    end
  end
  
  context "with invalid hash data" do

    let(:no_date) { {ask:ask_price, bid:bid_price} }
    let(:no_ask)  { {date:price_date, bid:bid_price} }
    let(:no_bid)  { {date:price_date, ask:ask_price} }
    
    it "throws an ArgumentError with an empty hash" do
      expect { Stock::Data::QuotedPrice.new({}) }.
        to raise_error, ArgumentError
    end

    it "throws an ArgumentError without a date" do
      expect { Stock::Data::QuotedPrice.new(no_date) }.
        to raise_error, ArgumentError
    end

    it "throws an ArgumentError without an ask price" do
      expect { Stock::Data::QuotedPrice.new(no_ask) }.
        to raise_error, ArgumentError
    end

    it "throws an ArgumentError without a bid price" do
      expect { Stock::Data::QuotedPrice.new(no_bid) }.
        to raise_error, ArgumentError
    end


  end
  
end