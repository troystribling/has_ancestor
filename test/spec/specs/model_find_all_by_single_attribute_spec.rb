require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "queries for all models of a specified type that match a specified attribute when models with no ancestor" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_find_1]).save
    ParentModel.new(model_data[:parent_model_find_2]).save
    ParentModel.new(model_data[:parent_model_find_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should find all models that match specified model attribute and return model class for queries from model class" do
    mods = ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:parent_model_find_1]['parent_model_string']}'")
    mods.should have_attributes_with_values([model_data[:parent_model_find_1], model_data[:parent_model_find_2]]) 
    mods.should be_class(ParentModel)
  end

end

#########################################################################################################
describe "queries for all models of a specified type that match a specified attribute when models have an ancestor" do

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

  it "should find all models that match specified ancestor model attribute and return ancestor model class for queries from ancestor model class" do
    mods = ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_find_1]['parent_model_string']}'")
    mods.should have_attributes_with_values([model_data[:parent_child_model_find_1], model_data[:parent_child_model_find_2]]) 
    mods.should be_class(ParentModel)
  end

  it "should find all models that match specified ancestor model attribute and return model class for queries from model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_find_1]['parent_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_model_find_1], model_data[:child_model_find_2]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match specified model attribute and return model class for queries from model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "child_models.child_model_string = '#{model_data[:child_model_find_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_model_find_1], model_data[:child_model_find_2]]) 
    mods.should be_class(ChildModel)
  end

end

#########################################################################################################
describe "queries for all models of a specified type that match a specified attribute attribute when models have an ancestor with an ancestor" do

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

  it "should find all models that match specified ancestor's ancestor model attribute and return ancestor's ancestor model class for queries from ancestor's ancestor model class" do
    mods = ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_find_1]['parent_model_string']}'")
    mods.should have_attributes_with_values([model_data[:parent_grandchild_model_find_1], model_data[:parent_grandchild_model_find_2]]) 
    mods.should be_class(ParentModel)
  end

  it "should find all models that match specified ancestor's ancestor model attribute and return ancestor model class for queries from ancestor model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_find_1]['parent_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_find_1], model_data[:child_grandchild_model_find_2]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match specified ancestor model attribute and return ancestor model class for queries from ancestor model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_find_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_find_1], model_data[:child_grandchild_model_find_1]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match specified ancestor's ancestor model attribute and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_find_1]['parent_model_string']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_find_1], model_data[:grandchild_model_find_2]]) 
    mods.should be_class(GrandchildModel)
  end

  it "should find all models that match specified ancestor model attribute and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_find_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_find_1], model_data[:grandchild_model_find_1]]) 
    mods.should be_class(GrandchildModel)
  end

  it "should find all models that match specified model attribute and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_find_1]['grandchild_model_string']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_find_1], model_data[:grandchild_model_find_1]]) 
    mods.should be_class(GrandchildModel)
  end

end
