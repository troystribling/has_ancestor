require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "queries that find a all models of a specified type that match multiple specified attribute conditions when models have no ancestor" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
    ParentModel.new(model_data[:parent_model_4]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find all models that match conditions specified on mutiple model attributes and return model class for queries from model class" do
    mods = ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:parent_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:parent_model_1]['parent_model_integer']}'")
    mods.should have_attributes_with_values([model_data[:parent_model_1], model_data[:parent_model_2]]) 
    mods.should be_class(ParentModel)
  end

end

#################################################################################################
describe "queries that find a all models of a specified type that match multiple specified attribute conditions when models have an ancestor" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
    ChildModel.new(model_data[:child_model_2]).save
    ChildModel.new(model_data[:child_model_3]).save
    ChildModel.new(model_data[:child_model_4]).save
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
    ParentModel.new(model_data[:parent_model_4]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find all models that match conditions specified on mutiple ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mods = ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:child_model_1]['parent_model_integer']}'")
    mods.should have_attributes_with_values([model_data[:parent_child_model_1], model_data[:parent_child_model_2]]) 
    mods.should be_class(ParentModel)
  end

  it "should find all models that match conditions specified on mutiple ancestor model attributes and return model class for queries from model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:child_model_1]['parent_model_integer']}'")
    mods.should have_attributes_with_values([model_data[:child_model_1], model_data[:child_model_2]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match conditions specified on multiple model attributes and return model class for queries from model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "child_models.child_model_string = '#{model_data[:child_model_1]['child_model_string']}' and child_models.child_model_string = '#{model_data[:child_model_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_model_1], model_data[:child_model_2]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match conditions specified on both ancestor model attributes and model attributes and return model class for queries from model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_1]['parent_model_string']}' and child_models.child_model_string = '#{model_data[:child_model_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_model_1], model_data[:child_model_2]]) 
    mods.should be_class(ChildModel)
  end

end

#################################################################################################
describe "queries that find a all models of a specified type that match multiple specified attribute conditions when models have an ancestor with an ancestor" do

  before(:all) do
    GrandchildModel.new(model_data[:grandchild_model_1]).save
    GrandchildModel.new(model_data[:grandchild_model_2]).save
    GrandchildModel.new(model_data[:grandchild_model_3]).save
    GrandchildModel.new(model_data[:grandchild_model_4]).save
    ChildModel.new(model_data[:child_model_1]).save
    ChildModel.new(model_data[:child_model_2]).save
    ChildModel.new(model_data[:child_model_3]).save
    ChildModel.new(model_data[:child_model_4]).save
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
    ParentModel.new(model_data[:parent_model_4]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find all models that match conditions specified on mutiple ancestor's ancestor model attributes and return ancestor's ancestor model class for queries from ancestor's ancestor model class" do
    mods = ParentModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:grandchild_model_1]['parent_model_integer']}'")
    mods.should have_attributes_with_values([model_data[:parent_grandchild_model_1], model_data[:parent_grandchild_model_2]]) 
    mods.should be_class(ParentModel)
  end

  it "should find all models that match conditions specified on mutiple ancestor's ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:grandchild_model_1]['parent_model_integer']}'")
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_1], model_data[:child_grandchild_model_2]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match conditions specified on mutiple ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_1], model_data[:child_grandchild_model_2]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match conditions specified on both ancestor's ancestor model attributes and ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mods = ChildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_1], model_data[:child_grandchild_model_2]]) 
    mods.should be_class(ChildModel)
  end

  it "should find all models that match conditions specified on mutiple ancestor's ancestor model attributes and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:grandchild_model_1]['parent_model_integer']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]]) 
    mods.should be_class(GrandchildModel)
  end

  it "should find all models that match conditions specified on mutiple ancestor model attributes and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]]) 
    mods.should be_class(GrandchildModel)
  end

  it "should find all models that match conditions specified on multiple model attributes and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_1]['grandchild_model_string']}' and grandchild_models.grandchild_model_integer = '#{model_data[:grandchild_model_1]['grandchild_model_integer']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]]) 
    mods.should be_class(GrandchildModel)
  end

  it "should find all models that match conditions specified on both ancestor's ancestor model attributes and ancestor model attributes and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]]) 
    mods.should be_class(GrandchildModel)
  end

  it "should find all models that match conditions specified on both ancestor's ancestor model attributes and model attributes and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_1]['grandchild_model_string']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]]) 
    mods.should be_class(GrandchildModel)
  end

  it "should find all models that match conditions specified on both ancestor model attributes and model attributes and return model class for queries from model class" do
    mods = GrandchildModel.find_by_model(:all, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}' and grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_1]['grandchild_model_string']}'")
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]]) 
    mods.should be_class(GrandchildModel)
  end

end
