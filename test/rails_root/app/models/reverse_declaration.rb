class ReverseDeclaration < ActiveRecord::Base

   ###############################################################
   #### declare descendant associations and ancestor 
   #### association with parent_model
   ###############################################################
   puts "has_ancestor"
   has_ancestor :named => :child_model    
   puts "has_descendants"
   has_descendants

end
