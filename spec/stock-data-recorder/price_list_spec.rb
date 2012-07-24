require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stock::Data::PriceList do
  
  subject { Stock::Data::PriceList.new }
  
  let(:past_date)   { DateTime.new(2012,01,01) }
  let(:recent_date) { DateTime.new(2012,06,01) }
  let(:past)   { {date:past_date, ask:2, bid:1} } 
  let(:recent) { {date:recent_date, ask:3, bid:2.5} }
    
  it { should be_empty }

  describe "<<" do
    
    it "adds a quoted price based on a suitable hash" do  
      subject << past
      subject.size.should == 1
    end                                             

    it "raises an Argument error if supplied hash is not suitable" do
      expect { subject << {} }.to raise_error ArgumentError
    end  

  end
    
  describe ".each" do

    it "iterates through the contents" do
      subject << past
      subject.each {|item| item.should 
        be_instance_of Stock::Data::QuotedPrice }
    end
    
  end

  describe ".sort" do

    it "from oldest to most recent" do
      subject << recent
      subject << past
      subject.sort.first.date.should == past[:date]
    end
    
  end
  
  describe ".clear" do

    it "all prices in the list" do
      subject << past
      subject.clear  
      subject.size.should == 0
    end
    
  end

  describe ".delete_for_date" do
    
    it "removes a price based on a specified datetime" do
      subject << past
      subject.delete_for_date(past_date)  
      subject.size.should == 0
    end

    it "removes all prices with the specified datetime" do
      subject << past
      subject << past
      subject.size.should == 2      
      subject.delete_for_date(past_date)  
      subject.size.should == 0      
    end
    
    it "only removes prices with with the specified datetime" do
      subject << past
      subject << recent
      subject.delete_for_date(past_date)  
      subject.size.should == 1      
    end
    
  end

end