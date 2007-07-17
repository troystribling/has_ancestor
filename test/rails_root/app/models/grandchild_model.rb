class GrandchildModel < ActiveRecord::Base

   ###############################################################
   #### declare ancestor association with child_model
   ###############################################################
   has_ancestor :named => :child_model  

   ###############################################################
   #### test method implementation 
   ###############################################################
   def method_on_descendant_grandchild_model
     self.grandchild_model_attr
   end

   ###############################################################
   #### test method delegation to ancestor
   ###############################################################
   def method_delegation_to_ancestor
     "#{grandchild_model_attr}:#{ancestor.method_delegation_to_ancestor}"
   end

   ###############################################################
   #### test method implementations that require agruments 
   ###############################################################
   def method_with_non_block_arguments(args)
     "#{self.grandchild_model_attr}:#{args[:argument]}"
   end

   def method_with_block_argument
     yield self
   end

   def method_with_block_argument_and_non_block_argument(args)
     yield args, self
   end

   ###############################################################
   #### test implimentation of before_hierarchy_save
   ###############################################################
   attr_accessor :grandchild_model_save
   def before_save
     @grandchild_model_save = true
   end


   ###############################################################
   #### class methods
   ###############################################################
   class << self

     ###############################################################
     #### test method implementation 
     ###############################################################
     def method_on_grandchild_model
       'method_on_grandchild_model'
     end
  
     ###############################################################
     #### test method delegation to ancestor
     ###############################################################
     def method_delegation_to_ancestor
       "method_on_grandchild_model:#{ChildModel.method_delegation_to_ancestor}"
     end
    
   end
   
end
