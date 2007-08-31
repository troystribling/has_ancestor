##############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class BeClass < PlanB::SpecMatchers::ArrayMatcher #:nodoc:
      
        def description
          "match array of classes"
        end

        def check_expected(val, expt)
          expt.detect {|e| not e.class.eql?(val.attributes[k])}.nil? ? true : false
        end

#        def message(msg)
#          expected_error.each do |k, v|
#            msg << "For #{k}: expected: #{v}, got: #{value_error[k]}\n" 
#          end
#          msg
#        end
          
      end
    
      def be_class(expected)
        BeClass.new(expected)
      end
   
  end
end