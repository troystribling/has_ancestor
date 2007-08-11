class CreateHasAncestorModel < ActiveRecord::Migration

  def self.up

    create_table :parent_models, :force => true, :primary_key => :parent_model_id do |t|
      t.column :parent_model_descendant_id, :integer
      t.column :parent_model_descendant_type, :string
      t.column :parent_model_attr, :string
      t.column :parent_model_other_attr, :string
    end
   
    create_table :child_models, :force => true, :primary_key => :child_model_id  do |t|
      t.column :child_model_descendant_id, :integer
      t.column :child_model_descendant_type, :string
      t.column :child_model_attr, :string
      t.column :child_model_other_attr, :string
    end
  
    create_table :grandchild_models, :force => true, :primary_key => :grandchild_model_id  do |t|
      t.column :grandchild_model_attr, :string
    end
    
    create_table :item_purchases, :force => true, :primary_key => :item_purchase_id do |t|
      t.column :item_purchase_descendant_id, :integer
      t.column :item_purchase_descendant_type, :string
      t.column :closed, :integer, :default=>0
      t.column :item, :string
      t.column :unit_cost, :integer
      t.column :unit_count, :integer
      t.column :cost, :integer      
    end
   
    create_table :stock_item_purchases, :force => true, :primary_key => :stock_item_purchase_id  do |t|
      t.column :in_inventory, :integer, :default => 0
    end

    create_table :contract_item_purchases, :force => true, :primary_key => :contract_item_purchase_id  do |t|
      t.column :length, :integer
    end
    
  end
  
  def self.down
  
    drop_table :parent_models
    drop_table :child_models
    drop_table :grandchild_models

    drop_table :item_purchases
    drop_table :stock_item_purchases
    drop_table :contract_item_purchases

  end
  
end