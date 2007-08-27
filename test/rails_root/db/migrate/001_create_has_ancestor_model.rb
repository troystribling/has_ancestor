class CreateHasAncestorModel < ActiveRecord::Migration

  def self.up

    create_table :parent_models, :force => true, :primary_key => :parent_model_id do |t|
      t.column :parent_model_descendant_id, :integer
      t.column :parent_model_descendant_type, :string
      t.column :parent_model_string, :string, :default => 'aString'
      t.column :parent_model_integer, :integer, :default => 0
      t.column :parent_model_float, :float, :default => 1.0
      t.column :parent_model_decimal, :decimal, :default => 1.0
      t.column :parent_model_date, :date, :default => Date.today
      t.column :parent_model_time, :time, :default => Time.now
      t.column :parent_model_datetime, :datetime, :default => Time.now
      t.column :parent_model_timestamp, :timestamp, :default => Time.now
      t.column :parent_model_boolean, :boolean, :default => true
    end
   
    create_table :child_models, :force => true, :primary_key => :child_model_id  do |t|
      t.column :child_model_descendant_id, :integer
      t.column :child_model_descendant_type, :string
      t.column :child_model_string, :string, :default => 'aString'
      t.column :child_model_integer, :integer, :default => 0
      t.column :child_model_float, :float, :default => 1.0
      t.column :child_model_decimal, :decimal, :default => 1.0
      t.column :child_model_date, :date, :default => Date.today
      t.column :child_model_time, :time, :default => Time.now
      t.column :child_model_datetime, :datetime, :default => Time.now
      t.column :child_model_timestamp, :timestamp, :default => Time.now
      t.column :child_model_boolean, :boolean, :default => true
    end
  
    create_table :grandchild_models, :force => true, :primary_key => :grandchild_model_id  do |t|
      t.column :grandchild_model_string, :string, :default => 'aString'
      t.column :grandchild_model_integer, :integer, :default => 0
      t.column :grandchild_model_float, :float, :default => 1.0
      t.column :grandchild_model_decimal, :decimal, :default => 1.0
      t.column :grandchild_model_date, :date, :default => Date.today
      t.column :grandchild_model_time, :time, :default => Time.now
      t.column :grandchild_model_datetime, :datetime, :default => Time.now
      t.column :grandchild_model_timestamp, :timestamp, :default => Time.now
      t.column :grandchild_model_boolean, :boolean, :default => true
    end
    
    create_table :item_purchases, :force => true, :primary_key => :item_purchase_id do |t|
      t.column :item_purchase_descendant_id, :integer
      t.column :item_purchase_descendant_type, :string
      t.column :closed, :integer, :default => 0
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