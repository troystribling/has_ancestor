require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "saving model that has no ancestor" do

  before(:each) do
    @p = ParentModel.new(model_data[:parent_model_1])
  end

  after(:each) do
    @p.destroy
  end

  it "should create model when it does not exist" do
    @p.should_not persist
    @p.save
    @p.should persist
  end

  it "should update model if it exists in database" do
    @p.save
    @p.should have_attributes_with_values(model_data[:parent_model_1])
    up_model = ParentModel.find(@p.id)
    up_model.attributes = model_data[:parent_model_2]
    up_model.save
    ParentModel.find(up_model.id).should have_attributes_with_values(model_data[:parent_model_2])
  end

end

########################################################################################################
describe "saving model that has an ancestor" do

  before(:each) do
    @c = ChildModel.new(model_data[:child_model_1])
  end

  after(:all) do
   @c.destroy
  end

  it "should create model and ancestor model when model does not exist" do
    @c.should_not persist
    @c.ancestor.should_not persist
    @c.save
    @c.should persist
    @c.ancestor.should persist
  end
  
  it "should update model attributes and ancestor attributes when model exists" do
    @c.save
    @c.should have_attributes_with_values(model_data[:child_model_1])
    up_model = ChildModel.find(@c.id)
    up_model.attributes = model_data[:child_model_2]
    up_model.save
    ChildModel.find(up_model.id).should have_attributes_with_values(model_data[:child_model_2])
  end
  
end

#########################################################################################################
describe "saving model that has an ancestor with an ancestor" do

  before(:each) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
  end

  after(:each) do
    @g.destroy
  end

  it "should create model ancestor model and ancestor's ancestor model when model does not exist" do
    @g.should_not persist
    @g.ancestor.should_not persist
    @g.ancestor.ancestor.should_not persist
    @g.save
    @g.should persist
    @g.ancestor.should persist
    @g.ancestor.ancestor.should persist
  end
  
  it "should update model attributes, ancestor attributes, and ancestor's ancestor attributes when it does exist" do
    @g.save
    @g.should have_attributes_with_values(model_data[:grandchild_model_1])
    up_model = GrandchildModel.find(@g.id)
    up_model.attributes = model_data[:grandchild_model_2]
    up_model.save
    GrandchildModel.find(up_model.id).should have_attributes_with_values(model_data[:grandchild_model_2])
  end

end

#########################################################################################################
describe "callback executed before database save of any model instance in an inheritance hierarchy" do

  it "should execute callback implemented on model on model save when model has no ancestor" do
    p = ParentModel.new(model_data[:parent_model_1])
    p.save
    p.parent_model_save.should be_true 
    p.destroy
  end

  it "should execute callback implemented on ancestor model on model save when model has an ancestor" do
    c = ChildModel.new(model_data[:child_model_1])
    c.parent_model_save.should be_nil 
    c.save
    c.parent_model_save.should be_true 
    c.destroy
  end

  it "should execute callback implemented on ancestor's ancestor model on model save when model has an acestor with an ancestor" do
    g = GrandchildModel.new(model_data[:child_model_1])
    g.parent_model_save.should be_nil 
    g.save
    g.parent_model_save.should be_true 
    g.destroy
  end

end

#########################################################################################################
describe "conditions under which not all models in inheritance hierarchy are saved" do

  it "if a model has descendants a descendant will not be saved if the model is saved" do
    c = ChildModel.new(model_data[:child_model_1])
    c.save
    p = ParentModel.find(c.parent_model_id)
    p.descendant.child_model_save.should be_nil 
    p.save
    p.descendant.child_model_save.should be_nil 
    c.destroy
  end

end


