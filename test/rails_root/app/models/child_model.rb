class ChildModel < ActiveRecord::Base

   ###############################################################
   #### declare descendant associations and ancestor 
   #### association with parent_model
   ###############################################################
   has_descendants
   has_ancestor :named => :parent_model    

   ###############################################################
   #### test method implementation 
   ###############################################################
   def method_on_descendant_child_model
     self.child_model_string
   end

   def method_on_descendant_grandchild_model
     self.child_model_string
   end

   def method_on_child_model
     self.child_model_string
   end

   def method_on_ancestor_model
     self.child_model_string
   end

   ###############################################################
   #### test method delegation to ancestor
   ###############################################################
   def method_delegation_to_ancestor
     "#{self.child_model_string}:#{ancestor.method_delegation_to_ancestor}"
   end
   
   ###############################################################
   #### test implementation of descendant_initialize
   ###############################################################
   attr_accessor :descendant_init_called
   def descendant_initialize(*args)
     @descendant_init_called = true
     unless args[0].nil?
       @descendant_init_called = args[0][:descendant_init_called] unless args[0][:descendant_init_called].nil? 
     end
   end

   ###############################################################
   #### test implementation of descendant_method_missing
   ###############################################################
   def descendant_method_missing(meth, *args, &blk)
     if meth.to_s.eql?('print_this')
         "#{meth.to_s}_from_instance"
     else
       get_parent_model.send(meth, *args, &blk)
     end
   end
    
   ###############################################################
   #### test implimentation of before_save
   ###############################################################
   attr_accessor :child_model_save
   def before_save
     @child_model_save = true
   end

   ###############################################################
   #### class methods
   ###############################################################
   class << self

     ###############################################################
     #### test method implementation 
     ###############################################################
     def method_on_child_model
       'method_on_child_model'
     end
  
     def method_on_grandchild_model
       'method_on_child_model'
     end
  
     ###############################################################
     #### test method delegation to ancestor
     ###############################################################
     def method_delegation_to_ancestor
       "method_on_child_model:#{ParentModel.method_delegation_to_ancestor}"
     end

     ###############################################################
     #### test implementation of descendant_method_missing
     ###############################################################
     def descendant_method_missing(meth, *args, &blk)
       if meth.to_s.eql?('print_this')
         "#{meth.to_s}_from_class"
       else
         ParentModel.send(meth, *args, &blk)
       end
     end
   
   end
       
end
