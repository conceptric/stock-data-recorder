require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::PriceList do
  
  subject { Stock::Data::PriceList.new }
  let(:past) { 
    Stock::Data::QuotedPrice.new(DateTime.new(2012,01,01), 2, 1) } 
  let(:recent) { 
    Stock::Data::QuotedPrice.new(DateTime.new(2012,06,01), 3, 2.5) }
    
  it { should be_empty }

  it "allows a quoted price to be added" do  
    subject << past
    subject.size.should == 1
  end                                             
  
  it "will only add a Quoted Price" do
    subject << 1
    subject << 1.0
    subject << '1'
    subject << true
    subject << [1]
    subject << {one:1}
    subject.should be_empty
  end  
  
  it "supports iteration through the contents" do
    subject << past
    subject.each {|item| item.should 
      be_instance_of Stock::Data::QuotedPrice }
  end

  it "can be sorted from oldest to most recent" do
    subject << recent
    subject << past
    subject.sort.first.should == past
  end
    
end