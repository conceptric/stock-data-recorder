require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Stock::Data::QuotedPrice" do              

  let(:price_date) { DateTime.new(2012,05,31) }
  let(:ask_price) { 100.0 }
  let(:bid_price) { 100.0 }
  let(:valid_data) { {date:price_date, ask:ask_price, bid:bid_price} }  
  let(:invalid_types) { [1, 1.0, 'one', true, [], (1..10)] }

  subject { Stock::Data::QuotedPrice.new(valid_data) }

  describe ".new" do

    shared_examples "a set of quoted prices" do
      its(:date) { should == price_date }
      its(:bid) { should == bid_price }
      its(:ask) { should == ask_price }
      its(:spread) { should == ask_price - bid_price }      
    end            
  
    context "with valid hash data" do
      it "returns the currency in which the prices are quoted"
  
      context "with matching prices" do
        it_behaves_like "a set of quoted prices"
      end
  
      context "with different prices" do
        let(:bid_price) { 80.0 }
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
    
    context "with the wrong data types for price" do
      shared_examples "invalid price data" do |attribute|
        let(:invalid_data) { valid_data }
        let(:invalid_numbers) { ['one', true, [], (1..10)] }
        it "throws an ArgumentError for #{attribute} price" do
          invalid_numbers.each do |invalid_type|
            invalid_data[attribute] = invalid_type
            expect { Stock::Data::QuotedPrice.new(invalid_data) }.
              to raise_error ArgumentError, 'Price must be a Fixnum or Float'      
          end
        end        
      end
      
      it_behaves_like "invalid price data", :ask
      it_behaves_like "invalid price data", :bid      
    end  
    
    context "without a valid DateTime for the quoted prices" do
      let(:invalid_data) { valid_data }
      
      it "throws an ArgumentError" do
        invalid_types.each do |invalid_type|
          invalid_data[:date] = invalid_type
          expect { Stock::Data::QuotedPrice.new(invalid_data) }.
            to raise_error ArgumentError, 'Date must be a Ruby DateTime object'      
        end
      end
    end    

    context "without a hash argument" do    
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