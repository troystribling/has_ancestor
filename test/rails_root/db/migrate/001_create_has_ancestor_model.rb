class CreateHasAncestorModel < ActiveRecord::Migration

  def self.up

    create_table :parent_models, :force => true, :primary_key => :parent_model_id do |t|
      t.column :parent_model_descendant_id, :integer
      t.column :parent_model_descendant_type, :string
      t.column :parent_model_attr, :string
    end
   
    create_table :child_models, :force => true, :primary_key => :child_model_id  do |t|
      t.column :child_model_attr, :string
      t.column :child_model_descendant_id, :integer
      t.column :child_model_descendant_type, :string
    end
  
    create_table :grandchild_models, :force => true, :primary_key => :grandchild_model_id  do |t|
      t.column :grandchild_model_attr, :string
    end
    
  end
  
  def self.down
  
    drop_table :parent_models
    drop_table :child_models
    drop_table :grandchild_models

  end
  
end