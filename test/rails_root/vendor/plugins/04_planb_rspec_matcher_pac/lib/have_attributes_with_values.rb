############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class HaveAttributesWithValues  #:nodoc:
    
        def initialize(expected)
          @expected = expected
        end
    
        def matches?(mod)  
          if mod.class.eql?(Array) and not @expected.class.eql?(Array)
            mod.find {|m| check_model_for_expected(m, @expected).eql?(false)}
          elsif not mod.class.eql?(Array) and @expected.class.eql?(Array)
          elsif mod.class.eql?(Array) and @expected.class.eql?(Array)
          else
            check_model_for_expected(mod)
          end
        end
        
        def check_model_for_expected(mod, expt)
          @attr = mod.attributes
          expt.find {|key, val| val.eql?(@attr[key])}.nil? ? true : false
        end
        
        def failure_message
          error_msg = "Attribute match error\n"
          @expected.each do |key, val|
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