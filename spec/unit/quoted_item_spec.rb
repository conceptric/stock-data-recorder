class QuotedItem
  def initialize
    
  end
    
end         

describe QuotedItem do
  it "exists" do
    subject.should be_true
  end                     
   
  describe ".new" do
    it "creates an instance" do
      QuotedItem.new.should be_instance_of QuotedItem
    end                    
  end
end