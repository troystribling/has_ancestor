##############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class HaveAttributesWithValues < PlanB::SpecMatchers::ArrayMatcher #:nodoc:
      
        def description
          "match array of hashes"
        end

        def check_expected(val, expt)
          expt.detect{|k, v| not v.eql?(val.attributes[k])}.nil? ? true : false
        end
          
        def message(msg)
          msg << "Expected:\n  #{expected_error.inspect}\n"
          if @not_matched.nil?
            expected_error.each {|k, v| msg << "Got:\n  #{value[i][k]}\n"}
          else
            (0..@not_matched.length-1).each {|i| msg << "Got:\n  #{@value[i].inspect}\n" if @not_matched[i]}
          end              
          msg
        end
          
      end
    
      def have_attributes_with_values(expected)
        HaveAttributesWithValues.new(expected)
      end
   
  end
end