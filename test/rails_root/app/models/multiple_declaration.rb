class MultipleDeclaration < ActiveRecord::Base

   ###############################################################
   #### declare descendant associations and ancestor associations
   ###############################################################
   has_ancestor :named => :child_model    
   has_descendants
   has_descendants
   has_ancestor :named => :grandchild_model    

end
