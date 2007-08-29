##############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class HaveAttributesWithValues  #:nodoc:
    
        def initialize(expected)
          @expected = expected
          @expt_error = @expected
        end
    
        def matches?(val)  
          if val.class.eql?(Array) and not @expected.class.eql?(Array)
            check_vals(val, @expected, false)
          elsif not val.class.eql?(Array) and @expected.class.eql?(Array)
            @expected.detect do |e| 
              @expt_error = e
              check_expected(val, e).eql?(true)
            end.nil? ? false : true              
          elsif val.class.eql?(Array) and @expected.class.eql?(Array) 
            if val.length.eql?(@expected.length)
              @expected.detect do |e| 
                @expt_error = e
                check_vals(val, e, true).eql?(false)
              end.nil? ? true : false
            else
              @error_msg = "array length=#{val.length} expected array length=#{@expected.length}\n"
              false
            end
          else
            check_expected(mod, @expected)
          end
        end
        
        def check_vals(vals, expt, cond)
          match_val = vals.detect {|m| check_expected(m, expt).eql?(cond)}
          if match_val.nil?
            not cond
          else
            vals.delete(match_val) if cond
            cond
          end          
        end
        
        def failure_message
        p "failure"
          @error_msg.nil? ? message("Match Failure\n") : @error_msg
        end
  
        def negative_failure_message
          message("Matched\n")
        end
  
        def description
          "match array of values"
        end

        def check_expected(val, expt)
          expt.detect {|k, v| not val.eql?(val.attributes[k])}.nil? ? true : false
        end
        
        def message(msg)
          @expt_error.each do |k, v|
             msg << "'#{k}' expecting '#{v}'\n" 
          end
        end

  
      end
    
      def have_attributes_with_values(expected)
        HaveAttributesWithValues.new(expected)
      end
   
  end
end