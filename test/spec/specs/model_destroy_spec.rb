require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "deletion from database of model with no ancestor and no descendants" do

  before(:all) do
    @p = ParentModel.new(model_data['PARENT_MODEL'])
    @p.save
    ParentModel.delete(@p.id)
  end

  it "should be possible to delete model" do
    ParentModel.exists?(@p.id).should be_false 
  end

end

#########################################################################################################
describe "deletion from database of model that has descendants and no ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
    @p.destroy
  end

  after(:all) do
    @c.destroy
  end

  it "should be possible to delete model" do
    ParentModel.exists?(@p.id).should be_false 
  end

  it "should not model delete model descendant when model is deleted" do
    ChildModel.exists?(@c.id).should be_true 
  end

end

##########################################################################################################
describe "deletion from database of model that has an ancestor and no descendants" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
    @c.destroy
  end

  it "should be possible to delete model" do
    ParentModel.exists?(@p.id).should be_false 
  end

  it "should delete model ancestor when model is deleted" do
    ChildModel.exists?(@c.id).should be_false 
  end

end

#########################################################################################################
describe "deletion from database of model that has descendants and has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@c.parent_model_id)
    @c.destroy
  end

  after(:all) do
    @g.destroy
  end

  it "should be possible to delete model" do
    ChildModel.exists?(@c.id).should be_false 
  end

  it "should not delete model descendant when model is deleted" do
    GrandchildModel.exists?(@g.id).should be_true
  end

  it "should delete model ancestor when model is deleted" do
    ParentModel.exists?(@p.id).should be_false 
  end

end

#########################################################################################################
describe "deletion from database of model that has no descendants and has an ancestor has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@c.parent_model_id)
    @g.destroy
  end

  it "should be possible to delete model" do
    GrandchildModel.exists?(@c.id).should be_false
  end

  it "should delete model ancestor when model is deleted" do
    ChildModel.exists?(@c.id).should be_false 
  end

  it "should delete model ancestor's ancestor when model is deleted" do
    ParentModel.exists?(@p.id).should be_false 
  end

end
