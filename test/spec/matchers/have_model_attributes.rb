############################################################
# match attributes of model against hash of expected values
module PlanB
  module SpecMatchers    

      class HaveModelAttributes  #:nodoc:
    
        def initialize(expected)
          @expected = expected
        end
    
        def matches?(model)
          @model = model
          if model.class.eql?(Hash)
            result = @expected.find do |key, val|
              val != @model[key]
            end
          else
            result = @expected.find do |key, val|
              val != @model.send(key.to_sym)
            end
          end
          result.nil? ? true : false
        end
        
        def failure_message
          if @model.class.eql?(Hash)
            error_msg = "Attribute match error\n"
            @expected.each do |key, val|
               error_msg << " attribute value '#{@model[key]}' for '#{key}' expecting '#{val}'\n" 
            end
          else
            error_msg = "Attribute match error for '#{@model.class.name}'\n"
            @expected.each do |key, val|
               error_msg << " attribute value '#{@model.send(key.to_sym)}' for '#{key}' expecting '#{val}'\n" 
            end
          end
          error_msg
        end
  
        def description
          "match model attributes"
        end
  
      end
    
      def have_model_attributes(expected)
        HaveModelAttributes.new(expected)
      end
   
  end
end