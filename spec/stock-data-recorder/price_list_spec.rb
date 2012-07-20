require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::PriceList do
  
  subject { Stock::Data::PriceList.new }
  let(:past)   { {date:DateTime.new(2012,01,01), ask:2, bid:1} } 
  let(:recent) { {date:DateTime.new(2012,06,01), ask:3, bid:2.5} }
    
  it { should be_empty }

  it "allows a quoted price to be added from a suitable hash" do  
    subject << past
    subject.size.should == 1
  end                                             
    
  it "supports iteration through the contents" do
    subject << past
    subject.each {|item| item.should 
      be_instance_of Stock::Data::QuotedPrice }
  end

  it "can be sorted from oldest to most recent" do
    subject << recent
    subject << past
    subject.sort.first.date.should == past[:date]
  end
  
  it "raises an Argument error if invalid price data are provided" do
    expect { subject << {} }.to raise_error ArgumentError
  end  
end