require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "save model to database that has no descendants and has no ancestor" do

  before(:all) do
    @p = ParentModel.new(model_data['PARENT_MODEL'])
    @p.save!
  end

  after(:all) do
    @p.destroy
  end

  it "model be able to save model" do
    ParentModel.should exist(@p.id)
  end

end

########################################################################################################
describe "save model to database that has no descendants but has ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save!
  end

  after(:all) do
    @c.destroy
  end

  it "should be able to save model" do
    ChildModel.should exist(@c.id)
  end
  
  it "ancestor model should be saved when model is saved" do
    ParentModel.should exist(@c.parent_model_id)
  end

end

#########################################################################################################
describe "save model to database that has no descendants and has an ancestor that has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save!
  end

  after(:all) do
    @g.destroy
  end

  it "should be able to save model" do
    GrandchildModel.should exist(@g.id)
  end
  
  it "ancestor model should be saved when model is saved" do
    ChildModel.should exist(@g.child_model_id)
  end

  it "ancestor's ancestor model should be saved when model is saved" do
    ParentModel.should exist(ChildModel.find(@g.child_model_id).parent_model_id)
  end

end

#########################################################################################################
describe "callback executed before database save of any model instance in an inheritance hierarchy" do

  it "should execute callback implemented on model with no ancestor or descendant" do
    p = ParentModel.new(model_data['PARENT_MODEL'])
    p.save!
    p.parent_model_save.should be_true 
    p.destroy
  end

  it "should execute callback implemented on model that has descendants but no ancestor on model save" do
    c = ChildModel.new(model_data['CHILD_MODEL'])
    c.save
    p = ParentModel.find(c.parent_model_id)
    p.parent_model_save.should be_nil 
    p.save!
    p.parent_model_save.should be_true 
    c.destroy
  end

  it "should execute callback implemented on model that has descendants but no ancestor on descendant model save" do
    c = ChildModel.new(model_data['CHILD_MODEL'])
    c.parent_model_save.should be_nil 
    c.save!
    c.parent_model_save.should be_true 
    c.destroy
  end

  it "should execute callback implemented on model that has ancestor and has descendants on model save" do
    g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    g.save!
    c = ChildModel.find(g.child_model_id)
    c.child_model_save.should be_nil 
    c.save!
    c.child_model_save.should be_true 
    g.destroy
  end

  it "should execute callback implemented on model that has ancestor and has descendants on descendant model save" do
    g = GrandchildModel.new(model_data['CHILD_MODEL'])
    g.child_model_save.should be_nil 
    g.save!
    g.child_model_save.should be_true 
    g.destroy
  end

  it "should execute callback implemented on model that has descendants that have descendants when decsendant's descendant is saved" do
    g = GrandchildModel.new(model_data['CHILD_MODEL'])
    g.parent_model_save.should be_nil 
    g.save!
    g.parent_model_save.should be_true 
    g.destroy
  end

end

#########################################################################################################
describe "conditions under which not all models in inheritance hierarchy are saved" do

  it "if a model has descendants a descendant will not be saved if the model is saved" do
    c = ChildModel.new(model_data['CHILD_MODEL'])
    c.save!
    p = ParentModel.find(c.parent_model_id)
    p.descendant.child_model_save.should be_nil 
    p.save!
    p.descendant.child_model_save.should be_nil 
    c.destroy
  end

end


