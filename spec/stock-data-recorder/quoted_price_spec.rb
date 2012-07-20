require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::QuotedPrice do              
  let(:price_date) { DateTime.new(2012,05,31) }
  let(:ask_price) { 100.0 }
  let(:bid_price) { 100.0 }
  
  subject do
    Stock::Data::QuotedPrice.new(price_date, ask_price, bid_price)
  end            
  
  it "has the date the prices were quoted" do
    subject.date.should be_instance_of DateTime
  end            
  
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
                                     
    let(:past) { Stock::Data::QuotedPrice.new(DateTime.new(2012,01,01),
                          ask_price, bid_price) } 
    let(:recent) { Stock::Data::QuotedPrice.new(
      DateTime.new(2012,06,01), ask_price, bid_price) }
        
    it "can tell when two prices are of the same date" do
      same = Stock::Data::QuotedPrice.new(price_date, ask_price, bid_price)
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