class StockItemPurchase < ActiveRecord::Base

   has_ancestor :named => :item_purchase
   
end
