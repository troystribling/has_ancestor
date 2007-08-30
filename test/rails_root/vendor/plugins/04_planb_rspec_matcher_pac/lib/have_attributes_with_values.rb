##############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class HaveAttributesWithValues < PlanB::SpecMatchers::ArrayMatcher #:nodoc:
      
        def description
          "match array of hashes"
        end

        def check_expected(val, expt)
          expt.detect {|k, v| not v.eql?(val.attributes[k])}.nil? ? true : false
        end
          
        def message(msg)
          expected_error.each do |k, v|
            msg << "For #{k}: expected: #{v}, got: #{value_error[k]}\n" 
          end
          msg
        end
          
      end
    
      def have_attributes_with_values(expected)
        HaveAttributesWithValues.new(expected)
      end
   
  end
end