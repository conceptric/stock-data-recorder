require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::PriceList do
  
  subject { Stock::Data::PriceList.new }
  
  it { should be_empty }

  it "allows a quoted price to be added" do  
    subject << Stock::Data::QuotedPrice.new(
      DateTime.new(2012,06,01), 2, 1)
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
  
  it "allows iteration through the contents" do
    subject << Stock::Data::QuotedPrice.new(
      DateTime.new(2012,06,01), 2, 1)
    subject.each {|item| item.should 
      be_instance_of Stock::Data::QuotedPrice }
  end
  
end