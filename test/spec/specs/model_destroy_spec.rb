require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "destroying model with no ancestor" do

  before(:each) do
    @p = ParentModel.new(model_data[:parent_model_1])
    @p.save
  end
  
  after(:each) do
    @p.destroy
  end

  it "should delete model from database when destroy is called from model" do
    @p.should persist
    @p.destroy
    @p.should_not persist
  end

end

##########################################################################################################
describe "destroying model that has an ancestor" do

  before(:each) do
    @c = ChildModel.new(model_data[:child_model_1])
    @c.save
  end
  
  after(:each) do
    @c.destroy
  end

  it "should delete model and ancestor model from database when destroy is called from model" do
    @c.should persist
    @c.ancestor.should persist
    @c.destroy
    @c.should_not persist
    @c.ancestor.should_not persist
  end

  it "should delete ancestor model but not model from database when destroy is called from ancestor model" do
    @c.should persist
    @c.ancestor.should persist
    @c.ancestor.destroy
    @c.should persist
    @c.ancestor.should_not persist
  end

end

##########################################################################################################
describe "destroying model that has an ancestor with an ancestor" do
  before(:each) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
    @g.save
  end
  
  after(:each) do
    @g.destroy
  end

  it "should delete model, ancestor model and ancestor's ancestor model from database when destroy is called from model" do
    @g.should persist
    @g.ancestor.should persist
    @g.ancestor.ancestor.should persist
    @g.destroy
    @g.should_not persist
    @g.ancestor.should_not persist
    @g.ancestor.ancestor.should_not persist
  end

  it "should delete ancestor model and ancestor's ancestor model but not model from database when destroy is called from ancestor model" do
    @g.should persist
    @g.ancestor.should persist
    @g.ancestor.ancestor.should persist
    @g.ancestor.destroy
    @g.should persist
    @g.ancestor.should_not persist
    @g.ancestor.ancestor.should_not persist
  end

  it "should delete ancestor's ancestor model but not model and ancestor model from database when destroy is called from ancestor's ancestor model" do
    @g.should persist
    @g.ancestor.should persist
    @g.ancestor.ancestor.should persist
    @g.ancestor.ancestor.destroy
    @g.should persist
    @g.ancestor.should persist
    @g.ancestor.ancestor.should_not persist
  end

end
