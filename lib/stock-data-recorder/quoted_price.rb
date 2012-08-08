module Stock
  module Data
    class QuotedPrice
      include Comparable
      
      attr_reader :date, :bid, :ask

      def initialize(args)                              
        validate(args)
        @date = validate_datetime(args[:date])
        @bid = validate_number(args[:bid])
        @ask = validate_number(args[:ask])
      end
      
      def <=>(another)
        date <=> another.date
      end

      def spread
        ask - bid
      end                                           
      
      def to_csv
        "#{date},#{ask},#{bid}"
      end
      
      def validate_datetime(dt)
        if dt.class != DateTime
          raise ArgumentError, 'Date must be a Ruby DateTime object'
        end
        dt
      end                      
      
      def validate_number(number)                         
        test = true
        test = false if number.class == Float
        test = false if number.class == Fixnum
        raise ArgumentError, 'Price must be a Fixnum or Float' if test
        number
      end

      def validate(args)
        if args.class != Hash
          raise ArgumentError, 'Price data must be a hash'
        end
        if args.empty? || !args[:date] || !args[:ask] || !args[:bid]
          raise ArgumentError, 'The price data are incomplete'
        end        
      end

      private :validate_datetime, :validate_number, :validate
                                 
    end    
  end  
end
