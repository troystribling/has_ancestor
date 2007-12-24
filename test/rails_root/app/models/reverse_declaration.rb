class ReverseDeclaration < ActiveRecord::Base

   ###############################################################
   #### declare descendant associations and ancestor 
   #### association with parent_model
   ###############################################################
   has_ancestor :named => :child_model    
   has_descendants

end
