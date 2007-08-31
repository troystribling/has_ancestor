##############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class BeClass < PlanB::SpecMatchers::ArrayMatcher #:nodoc:
      
        def description
          "match array of classes"
        end

        def check_expected(val, expt)
          expt.eql?(val.class)
        end

        def message(msg)
          msg << "Expected:\n '#{expected_error}'"
          msg << "Got:\n '#{value_error[k]}'" unless value_error.nil?
          msg << "\n"           
        end

      end
    
      def be_class(expected)
        BeClass.new(expected)
      end
   
  end
end