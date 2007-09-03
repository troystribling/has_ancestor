############################################################
# verify that model can support descendant associations
module PlanB
  module SpecMatchers    

      class HaveAttribute  #:nodoc:

        def initialize(attr)
          @attr = attr
        end

        def matches?(mod)
          @mod = mod
          @mod.respond_to?(@attr)
        end
        
        def failure_message
          "#{@mod.class.name} does not support '#{@attr.to_s}'\n"
        end

        def negative_failure_message
          "#{@mod.class.name} supports '#{@attr.to_s}'\n"
        end

        def description
          "verify the existance of specified attribute on object"
        end
  
      end
    
      def have_attribute(attr)
        HaveAttribute.new(attr)
      end
   
  end
end