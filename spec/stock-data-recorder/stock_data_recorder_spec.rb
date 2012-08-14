require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'csv'

describe Stock::Data::Recorder do

  let(:tickers) { %w(BP.L GSK.L) }
  use_vcr_cassette "yahoo-api-query", :record => :new_episodes  

  describe ".new" do
    it "with an array of ticker symbols returns a new instance" do        
      Stock::Data::Recorder.new(tickers).should 
        be_instance_of Stock::Data::Recorder
    end    

    it "with an empty array returns a new instance" do        
      Stock::Data::Recorder.new([]).should 
        be_instance_of Stock::Data::Recorder
    end    

    it "without any arguments raises an Error" do        
      expect { Stock::Data::Recorder.new() }.to 
       raise_error ArgumentError
    end    
  end
  
  describe ".get" do

    context "with tickers defined" do        
      subject { Stock::Data::Recorder.new(tickers).get }     

      it "returns a collection with an entry for each ticker" do
        subject.size.should eql tickers.size
      end                 

      it "the first entry for the first ticker" do
        subject.first['symbol'].should eql tickers.first
      end      

      it "the last entry for the last ticker" do
        subject.last['symbol'].should eql tickers.last
      end      
    end
    
    context "with no tickers defined" do
      it "returns an empty collection" do        
        Stock::Data::Recorder.new([]).get.should be_empty
      end
    end                             
      
  end                                    
  
  describe ".write_to_csv" do

    let(:output) { StringIO.new }

    before(:each) do
      CSV.should_receive(:open).once.and_return(output)      
      output.should_receive(:close).once
    end         
    
    context "with tickers defined" do
      let(:symbol_regex) { '([A-Za-z]+\.[A-Za-z]+)' }
      let(:price_regex) { '([0-9]+\.[0-9]{2})' }
      let(:date_regex) { '(\d{4}(-{1}\d{2}){2})' }
      let(:time_regex) { 'T((\d{2}:{1}){2}(\d{2}){1})Z' }
      let(:output_regex) {
        symbol_regex + "," + 
        price_regex + "," + 
        price_regex + "," +
        date_regex + time_regex
      }

      before(:each) do
        Stock::Data::Recorder.new(tickers).write_to_csv
      end

      it "writes output with a symbol value" do
        output.string.should =~ Regexp.new(symbol_regex)
      end                                                   

      it "writes output with a price value" do
        output.string.should =~ Regexp.new(price_regex)
      end                                                   

      it "writes output with a datetime value" do
        output.string.should =~ Regexp.new(date_regex)
        output.string.should =~ Regexp.new(time_regex)
      end        
      
      it "writes output as comma-delimited" do        
        output.string.should =~ Regexp.new(output_regex)
      end                                           

      it "writes output with a single line for each ticker" do
        output.rewind
        output.readlines.size.should eql tickers.size
      end                                                 
    end
    
    context "with no tickers defined" do
      it "returns an writes nothing" do
        Stock::Data::Recorder.new([]).write_to_csv
        output.string.should eql ""
      end                                                   
    end
    
  end            
  
end