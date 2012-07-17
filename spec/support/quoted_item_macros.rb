module QuotedItemMacros
  
  def invalid_ticker_helper(ticker_type, message)
    expect {Stock::Data::QuotedItem.new(ticker_type)}.
    to raise_error ArgumentError, 
      message        
  end
  
end