##############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class HaveAttributesWithValues  #:nodoc:
    
        def initialize(expected)
          @expected = expected
          @expt_error = @expected
        end
    
        def matches?(mod)  
          if mod.class.eql?(Array) and not @expected.class.eql?(Array)
            check_models(mod, @expected, false)
          elsif not mod.class.eql?(Array) and @expected.class.eql?(Array)
            @expected.detect do |e| 
              @expt_error = e
              check_expected(mod,e).eql?(true)
            end.nil? ? false : true              
          elsif mod.class.eql?(Array) and @expected.class.eql?(Array) 
            @expected.detect do |e| 
              @expt_error = e
              check_models(mod,e, true).eql?(false)
            end.nil? ? true : false
          else
            check_expected(mod, @expected)
          end
        end
        
        def check_models(mod, expt, cond)
          mod.detect {|m| check_expected(m, expt).eql?(cond)}.nil? ? !cond : cond          
        end
        
        def check_expected(mod, expt)
          @attr = mod.attributes
          expt.detect {|key, val| not val.eql?(@attr[key])}.nil? ? true : false
        end
        
        def failure_message
          error_msg = "Attribute match error\n"
          @expt_error.each do |key, val|
             error_msg << " attribute value '#{@attr[key]}' for '#{key}' expecting '#{val}'\n" 
          end
          error_msg
        end
  
        def negative_failure_message
          error_msg = "Attribute match\n"
          @expt_error.each do |key, val|
             error_msg << " attribute value '#{@attr[key]}' for '#{key}' expecting '#{val}'\n" 
          end
          error_msg
        end
  
        def description
          "check model attribute values"
        end
  
      end
    
      def have_attributes_with_values(expected)
        HaveAttributesWithValues.new(expected)
      end
   
  end
end