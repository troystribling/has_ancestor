##############################################################
# match arrays of expected and values

module PlanB
  module SpecMatchers    

      class ArrayMatcher  #:nodoc:
    
        attr_reader :expected_error, :expected, :value_error, :msg_error, :matched_values
        
        def initialize(expected)
          @expected = expected
          @expected_error = @expected
        end
    
        def matches?(value)          
          @not_matched = Array.new(value.length, true) if value.class.eql?(Array)
          if value.class.eql?(Array) and not @expected.class.eql?(Array)
            check_values(value, @expected, false)
          elsif not value.class.eql?(Array) and @expected.class.eql?(Array)
            @value_error = value
            @expected.detect do |e| 
              @expected_error = e
              check_expected(value, e).eql?(true)
            end.nil? ? false : true              
          elsif value.class.eql?(Array) and @expected.class.eql?(Array) 
            if value.length.eql?(@expected.length)
              @expected.detect do |e| 
                @expected_error = e
                check_values(value, e, true).eql?(false)
              end.nil? ? true : false
            else
              @msg_error = "Expected:\n  array length=#{@expected.length}\n" + "Got:\n  array length=#{value.length}\n"
              false
            end
          else
            check_expected(mod, @expected)
          end
        end
        
        def check_values(values, expt, cond)
          match_index = (0..values.length-1).detect {|i| check_expected(values[i], expt).eql?(cond) and @not_matched[i]}
          if match_index.nil?
            not cond
          else
            @not_matched[match_index] = false
            cond
          end
        end
        
        def failure_message
          @msg_error.nil? ? message("Match Failure\n") : @msg_error
        end
  
        def negative_failure_message
          message("Matched\n")
        end
  
        def description
          "match array of scalars"
        end

        def message(msg)
          msg << "Expected:\n  #{@expected_error.inspect}\n" 
          msg << "Got:\n  #{@value_error.inspect}\n" unless @value_error.nil? 
        end

        def check_expected(val, expt)
          expt.eql?(val)
        end
          
      end
    
      def array_matcher(expected)
        ArrayMatcher.new(expected)
      end
   
  end
end