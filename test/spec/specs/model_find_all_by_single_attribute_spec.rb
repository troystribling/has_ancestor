require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "queries for all models of a specified type where the models have no ancestor and no descendants" do

  before(:all) do
    @p1 = ParentModel.new(model_data[:parent_model])
    @p1.save
    @p2 = ParentModel.new(model_data[:parent_model])
    @p2.save
  end

  after(:all) do
    @p1.destroy
    @p2.destroy
  end

  it "should find models by specification of model attribute" do
    ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_attr = '#{model_data[:parent_model]['parent_model_attr']}'").should \
      eql_attribute_value(:parent_model_attr, model_data[:parent_model]['parent_model_attr']) 
  end

  it "should find all models" do
    ParentModel.find_by_model(:all).should eql_attribute_value(:parent_model_attr, model_data[:parent_model]['parent_model_attr']) 
  end

end

#########################################################################################################
describe "queries for all models of a specified type where the models have no ancestor and have descendants" do

  before(:all) do
    @c1 = ChildModel.new(model_data[:child_model])
    @c1.save
    @c2 = ChildModel.new(model_data[:child_model_find_all_child])
    @c2.save
  end

  after(:all) do
    @c1.destroy
    @c2.destroy
  end

  it "should find models by specification of model attribute" do
    ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_attr = '#{model_data[:child_model]['parent_model_attr']}'").should \
      eql_attribute_value(:parent_model_attr, model_data[:child_model]['parent_model_attr']) 
  end

end

#########################################################################################################
describe "queries for all models of a specified type where the models have an ancestor and have no descendants" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
    @cp = ChildModel.new(model_data[:child_model_find_all_parent])
    @cp.save
    @cc = ChildModel.new(model_data[:child_model_find_all_child])
    @cc.save
  end

  after(:all) do
    @c.destroy
    @cp.destroy
    @cc.destroy
  end

  it "should find models by specification of model attribute" do
    ChildModel.find_by_model(:all, :conditions => "child_models.child_model_attr = '#{model_data[:child_model]['child_model_attr']}'").should \
      eql_attribute_value(:child_model_attr, model_data[:child_model]['child_model_attr']) 
  end

  it "should find models by specification of ancestor model attribute" do
    ChildModel.find_by_model(:all, :conditions => "parent_models.parent_model_attr = '#{model_data[:child_model]['parent_model_attr']}'").should \
      eql_attribute_value(:parent_model_attr, model_data[:child_model]['parent_model_attr']) 
  end

end

#########################################################################################################
describe "queries for all models of a specified type where the models have no descendants and have an ancestor has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
    @gp = GrandchildModel.new(model_data[:grandchild_model_find_all_parent])
    @gp.save
    @gc = GrandchildModel.new(model_data[:grandchild_model_find_all_child])
    @gc.save
    @gg = GrandchildModel.new(model_data[:grandchild_model_find_all_grandchild])
    @gg.save
  end

  after(:all) do
    @g.destroy
    @gp.destroy
    @gc.destroy
    @gg.destroy
  end

  it "should find models by specification of model attribute" do
    GrandchildModel.find_by_model(:all, :conditions => "grandchild_models.grandchild_model_attr = '#{model_data[:grandchild_model]['grandchild_model_attr']}'").should \
      eql_attribute_value(:grandchild_model_attr, model_data[:grandchild_model]['grandchild_model_attr']) 
  end

  it "should find models by specification of ancestor attribute" do
    GrandchildModel.find_by_model(:all, :conditions => "child_models.child_model_attr = '#{model_data[:grandchild_model]['child_model_attr']}'").should \
      eql_attribute_value(:child_model_attr, model_data[:grandchild_model]['child_model_attr']) 
  end

  it "should find models by specification of ancestor's ancestor attribute" do
    GrandchildModel.find_by_model(:all, :conditions => "parent_models.parent_model_attr = '#{model_data[:grandchild_model]['parent_model_attr']}'").should \
      eql_attribute_value(:parent_model_attr, model_data[:grandchild_model]['parent_model_attr']) 
  end

end
