class ParentModel < ActiveRecord::Base

   ###############################################################
   #### declare descendant associations
   ###############################################################
   has_descendants
   
   ###############################################################
   #### test instance method implementation 
   ###############################################################
   def method_on_parent_model
     parent_model_attr
   end
   
   def method_on_child_model
     parent_model_attr
   end
   
   def method_on_descendant_child_model
     parent_model_attr
   end

   def method_on_descendant_grandchild_model
     parent_model_attr
   end

   ###############################################################
   #### test instance method implementations that require agruments 
   ###############################################################
   def method_with_non_block_arguments(args)
     "#{parent_model_attr}:#{args[:argument]}"
   end

   def method_with_block_argument     
     yield descendant
   end

   def method_with_block_argument_and_non_block_argument(args)
     yield args, descendant
   end

   ###############################################################
   #### test instance method delegation to ancestor
   ###############################################################
   def method_delegation_to_ancestor
     parent_model_attr
   end

   ###############################################################
   #### test implimentation of before_hierarchy_save
   ###############################################################
   attr_accessor :parent_model_save
   def before_save
     @parent_model_save = true
   end
    
   ###############################################################
   #### class methods
   ###############################################################
   class << self

     ###############################################################
     #### test class  method implementation 
     ###############################################################
     def method_on_parent_model
       'method_on_parent_model'
     end
  
     def method_on_child_model
       'method_on_parent_model'
     end
  
     def method_on_grandchild_model
       'method_on_parent_model'
     end
  
     ###############################################################
     #### test class method implementations that require agruments 
     ###############################################################
     def method_with_non_block_arguments(args)
       "method_on_parent_model:#{args[:argument]}"
     end
  
     def method_with_block_argument     
       yield self
     end
  
     def method_with_block_argument_and_non_block_argument(args)
       yield args, self
     end
  
     ###############################################################
     #### test instance method delegation to ancestor
     ###############################################################
     def method_delegation_to_ancestor
       'method_on_parent_model'
     end
   end
         
end
