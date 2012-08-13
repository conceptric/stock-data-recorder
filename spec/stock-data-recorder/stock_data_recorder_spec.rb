require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'csv'

describe Stock::Data::Recorder do

  let(:tickers) { %w(BP.L GSK.L) }
  use_vcr_cassette "yahoo-api-query", :record => :new_episodes  

  describe ".new" do
    it "returns a new instance with an array of ticker strings" do        
      Stock::Data::Recorder.new(tickers).should be_true
    end    

    it "returns a new instance with a blank array" do        
      Stock::Data::Recorder.new([]).should be_true
    end    

    it "returns ArgumentError without an argument" do        
      expect { Stock::Data::Recorder.new() }.to raise_error ArgumentError
    end    
  end
  
  describe ".get" do

    context "with no tickers defined" do
      it "returns an empty collection" do        
        Stock::Data::Recorder.new([]).get.should be_empty
      end
    end                             
    
    context "with tickers defined" do        
      subject { Stock::Data::Recorder.new(tickers)}     

      it "returns a collection with an entry for each ticker" do
        subject.get.size.should eql tickers.size
      end                 

      it "the first entry for the first ticker" do
        subject.get.first['symbol'].should eql tickers.first
      end      

      it "the last entry for the last ticker" do
        subject.get.last['symbol'].should eql tickers.last
      end      
    end
  
  end                                    
  
  describe ".write_to_csv" do

    let(:output) { StringIO.new }

    before(:each) do
      CSV.should_receive(:open).once.and_return(output)      
      output.should_receive(:close).once
    end         
    
    context "with no tickers defined" do
      it "returns an writes nothing" do
        recorder = Stock::Data::Recorder.new([])
        recorder.write_to_csv
        output.string.should eql ""
      end                                                   
    end
    
    context "with tickers defined" do
      subject { Stock::Data::Recorder.new(tickers) }

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

      it "writes output with a symbol value" do
        subject.write_to_csv
        output.string.should =~ Regexp.new(symbol_regex)
      end                                                   

      it "writes output with a price value" do
        subject.write_to_csv
        output.string.should =~ Regexp.new(price_regex)
      end                                                   

      it "writes output with a datetime value" do
        subject.write_to_csv
        output.string.should =~ Regexp.new(date_regex)
        output.string.should =~ Regexp.new(time_regex)
      end        
      
      it "writes output as comma-delimited" do        
        subject.write_to_csv
        output.string.should =~ Regexp.new(output_regex)
      end                                           

      it "writes output with a single line for each ticker" do
        subject.write_to_csv
        output.rewind
        output.readlines.size.should eql tickers.size
      end                                                 
    end
    
  end            
  
end