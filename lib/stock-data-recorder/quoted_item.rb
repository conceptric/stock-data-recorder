class QuotedItem    
  attr_reader :ticker
  
  def initialize(ticker) 
    validate_ticker(ticker)
    @ticker = ticker
  end
                        
  private
  
  def validate_ticker(ticker)
    unless ticker.class == String
      raise ArgumentError, "Ticker must be a valid string", caller
    end
    raise ArgumentError, "Ticker cannot be blank", caller if ticker == "" 
  end  
end         
