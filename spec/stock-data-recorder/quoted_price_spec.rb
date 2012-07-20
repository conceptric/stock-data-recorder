require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Stock::Data::QuotedPrice" do              

  let(:price_date) { DateTime.new(2012,05,31) }
  let(:ask_price) { 100.0 }
  let(:bid_price) { 100.0 }
  let(:valid_data) { {date:price_date, ask:ask_price, bid:bid_price} }  
  subject { Stock::Data::QuotedPrice.new(valid_data) }

  describe ".new" do

    shared_examples "a set of quoted prices" do
      it "includes the date associated with the quote" do
        subject.date.should == price_date
      end      
     
      it "includes the bid price" do
        subject.bid.should == bid_price
      end

      it "includes the asking price" do
        subject.ask.should == ask_price
      end                          

      it "calculates spread between the two prices" do
        subject.spread.should == ask_price - bid_price
      end                
    end            
  
    context "with valid hash data" do
      it "returns the currency in which the prices are quoted"
  
      context "with matching prices" do
        it_behaves_like "a set of quoted prices"
      end
  
      context "with different prices" do
        let(:bid_price) { 100.0 }
        it_behaves_like "a set of quoted prices"
      end
    
    end

    context "with additional data in the hash" do      
      let(:extra_data) do
        valid_data[:extra] = 'ignore'
        valid_data
      end
      subject { Stock::Data::QuotedPrice.new(extra_data) }
      
      it "has extra input in the hash" do
        extra_data.should include :extra
      end
      
      it "does not raise an Error" do        
        expect { subject }.not_to raise_error
      end     
      
      it "does not include the extra data" do
        expect { subject.extra }.to raise_error
      end
      
      it_behaves_like "a set of quoted prices"      
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
  
    context "with missing hash data" do
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

  describe "are comparable" do

    let(:valid_past_data) { 
      {date:DateTime.new(2012,01,01), ask:ask_price, bid:bid_price} }
    let(:past) { Stock::Data::QuotedPrice.new(valid_past_data) } 

    let(:valid_recent_data) { 
      {date:DateTime.new(2012,06,01), ask:ask_price, bid:bid_price} }
    let(:recent) { Stock::Data::QuotedPrice.new(valid_recent_data) }
      
    it "can tell when two quotes are of the same date" do
      subject.should == Stock::Data::QuotedPrice.new(valid_data)
    end
  
    it "can tell when one quote is newer than another" do      
      subject.should > past
    end                                         
  
    it "can tell when one quote is older than another" do
      subject.should < recent      
    end
  
  end
  
end