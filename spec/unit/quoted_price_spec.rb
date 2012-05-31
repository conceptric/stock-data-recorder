require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class QuotedPrice
  attr_reader :date, :bid, :ask

  def initialize(date, ask, bid)
    @date = date
    @bid = bid
    @ask = ask
  end
  
  def spread
    ask - bid
  end
end

describe QuotedPrice do              
  let(:price_date) { DateTime.new(2012,05,31) }
  let(:ask_price) { 110.0 }
  let(:bid_price) { 110.0 }
  
  subject do
    QuotedPrice.new(price_date, ask_price, bid_price)
  end            
  
  it "has a date attribute" do
    subject.date.should be_instance_of DateTime
  end            
  
  it "returns the date when asked" do
    subject.date.should == price_date
  end

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
end