####################################################
module PlanB 
  
  ####################################################
  module Has 

    ####################################################
    module Ancestor 

      ####################################################
      module InstanceMethods
        
        ##################################################
        module AncestorMethods #:nodoc :all
    
          def self.add_methods(target)
    
            target.class_eval <<-do_eval

              def get_descendant
                #{target.to_s.tableize.singularize}_descendant      
              end
                  
            do_eval
    
          end           
    
        end
  
      end

    end

  end

end