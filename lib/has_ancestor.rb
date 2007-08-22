####################################################
module PlanB 
  
  ####################################################
  # invalid attribute type specified
  class InvalidType < ArgumentError; end  

  ####################################################
  module Has 

    ####################################################
    module Ancestor 

      ###################################################
      def self.included(base) #:nodoc
        base.extend(ClassMethods)  
      end
  
      ###################################################
      module ClassMethods
  
        #################################################
        # Declare a model has descendants
        def has_descendants
          self.primary_key = "#{self.name.tableize.singularize}_id"
          eval("belongs_to :#{self.name.tableize.singularize}_descendant, :polymorphic => true")
          InstanceMethods::AncestorAndDescendantMethods.add_methods(self, '')
          InstanceMethods::AncestorMethods.add_methods(self)
        end
        
        ##################################################
        # Declare a model ancestor
        def has_ancestor(args = {}) 
          args.assert_valid_keys(:named)
          self.primary_key = "#{self.name.tableize.singularize}_id"
          eval("has_one args[:named], :as => :#{args[:named]}_descendant, :dependent => :destroy")
          InstanceMethods::AncestorAndDescendantMethods.add_methods(self, args[:named])
          InstanceMethods::DescendantMethods.add_methods(self, args[:named])
        end       
                                
      end
  
      ####################################################
      module SingletonMethods #:nodoc :all
      end
                
    end
  end 
     
end