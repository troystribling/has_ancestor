require File.dirname(__FILE__) + '/../spec_helper'

##################################################################################################
describe "queries that find a model of a specified type that matches multiple specified attribute conditions when model has no ancestor" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_1]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should find first model that matches conditions specified on mutiple model attributes and return model class for queries from model class" do
    mod = ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:parent_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:parent_model_1]['parent_model_integer']}'")
    mod.should have_attributes_with_values(model_data[:parent_model_1]) 
    mod.should be_class(ParentModel)
  end

end

#################################################################################################
describe "queries that find a model of a specified type that matches multiple specified attribute conditions when model has and ancestor" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
  end

  after(:all) do
    ChildModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find first model that matches conditions specified on mutiple ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mod = ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:child_model_1]['parent_model_integer']}'")
    mod.should have_attributes_with_values(model_data[:parent_child_model_1]) 
    mod.should be_class(ParentModel)
  end

  it "should find first model that matches conditions specified on mutiple ancestor model attributes and return model class for queries from model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:child_model_1]['parent_model_integer']}'")
    mod.should have_attributes_with_values(model_data[:child_model_1]) 
    mod.should be_class(ChildModel)
  end

  it "should find first model that matches conditions specified on multiple model attributes and return model class for queries from model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "child_models.child_model_string = '#{model_data[:child_model_1]['child_model_string']}' and child_models.child_model_string = '#{model_data[:child_model_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_model_1]) 
    mod.should be_class(ChildModel)
  end

  it "should find first model that matches conditions specified on both ancestor model attributes and model attributes and return model class for queries from model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_1]['parent_model_string']}' and child_models.child_model_string = '#{model_data[:child_model_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_model_1]) 
    mod.should be_class(ChildModel)
  end

end

#################################################################################################
describe "queries that find a model of a specified type that matches multiple specified attribute conditions when model has and ancestor with and ancestor" do

  before(:all) do
    GrandchildModel.new(model_data[:grandchild_model_1]).save
  end

  after(:all) do
    GrandchildModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find first model that matches conditions specified on mutiple ancestor's ancestor model attributes and return ancestor's ancestor model class for queries from ancestor's ancestor model class" do
    mod = ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:grandchild_model_1]['parent_model_integer']}'")
    mod.should have_attributes_with_values(model_data[:parent_grandchild_model_1]) 
    mod.should be_class(ParentModel)
  end

  it "should find first model that matches conditions specified on mutiple ancestor's ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:grandchild_model_1]['parent_model_integer']}'")
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_1]) 
    mod.should be_class(ChildModel)
  end

  it "should find first model that matches conditions specified on mutiple ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_1]) 
    mod.should be_class(ChildModel)
  end

  it "should find first model that matches conditions specified on both ancestor's ancestor model attributes and ancestor model attributes and return ancestor model class for queries from ancestor model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_1]) 
    mod.should be_class(ChildModel)
  end

  it "should find first model that matches conditions specified on mutiple ancestor's ancestor model attributes and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and parent_models.parent_model_integer = '#{model_data[:grandchild_model_1]['parent_model_integer']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_1]) 
    mod.should be_class(GrandchildModel)
  end

  it "should find first model that matches conditions specified on mutiple ancestor model attributes and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_find_1]['child_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_find_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_1]) 
    mod.should be_class(GrandchildModel)
  end

  it "should find first model that matches conditions specified on multiple model attributes and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_find_1]['grandchild_model_string']}' and grandchild_models.grandchild_model_integer = '#{model_data[:grandchild_model_find_1]['grandchild_model_integer']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_1]) 
    mod.should be_class(GrandchildModel)
  end

  it "should find first model that matches conditions specified on both ancestor's ancestor model attributes and ancestor model attributes and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_1]) 
    mod.should be_class(GrandchildModel)
  end

  it "should find first model that matches conditions specified on both ancestor's ancestor model attributes and model attributes and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}' and grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_1]['grandchild_model_string']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_1]) 
    mod.should be_class(GrandchildModel)
  end

  it "should find first model that matches conditions specified on both ancestor model attributes and model attributes and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}' and grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_1]['grandchild_model_string']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_1]) 
    mod.should be_class(GrandchildModel)
  end

end
