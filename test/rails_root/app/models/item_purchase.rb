class ItemPurchase < ActiveRecord::Base

   has_descendants
       
   def close_item_purchase
     self.cost = unit_count * unit_cost
     self.closed = 1      
   end
   
end
