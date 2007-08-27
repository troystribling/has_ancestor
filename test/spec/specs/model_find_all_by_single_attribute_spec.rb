require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "queries for all models of a specified type where the models have no ancestor and no descendants" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_find_1]).save
    ParentModel.new(model_data[:parent_model_find_2]).save
    ParentModel.new(model_data[:parent_model_find_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.destroy}
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
    ChildModel.new(model_data[:child_model_find_1]).save
    ChildModel.new(model_data[:child_model_find_2]).save
    ChildModel.new(model_data[:child_model_find_3]).save
    ParentModel.new(model_data[:parent_model_find_1]).save
    ParentModel.new(model_data[:parent_model_find_2]).save
    ParentModel.new(model_data[:parent_model_find_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find models by specification of model attribute" do
    ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_attr = '#{model_data[:child_model]['parent_model_attr']}'").should \
      eql_attribute_value(:parent_model_attr, model_data[:child_model]['parent_model_attr']) 
  end

end

#########################################################################################################
describe "queries for all models of a specified type where the models have an ancestor and have no descendants" do

  before(:all) do
    ChildModel.new(model_data[:child_model_find_1]).save
    ChildModel.new(model_data[:child_model_find_2]).save
    ChildModel.new(model_data[:child_model_find_3]).save
    ParentModel.new(model_data[:parent_model_find_1]).save
    ParentModel.new(model_data[:parent_model_find_2]).save
    ParentModel.new(model_data[:parent_model_find_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
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
    ChildModel.new(model_data[:child_model_find_1]).save
    ChildModel.new(model_data[:child_model_find_2]).save
    ChildModel.new(model_data[:child_model_find_3]).save
    ParentModel.new(model_data[:parent_model_find_1]).save
    ParentModel.new(model_data[:parent_model_find_2]).save
    ParentModel.new(model_data[:parent_model_find_3]).save
    GrandchildModel.new(model_data[:grandchild_model_find_1]).save
    GrandchildModel.new(model_data[:grandchild_model_find_2]).save
    GrandchildModel.new(model_data[:grandchild_model_find_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
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
