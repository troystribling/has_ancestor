class ContractItemPurchase < ActiveRecord::Base

   has_ancestor :named => :item_purchase

   def close_item_purchase
     self.cost = self.length * self.unit_count * self.unit_cost
     self.closed = 1      
   end
   
end
