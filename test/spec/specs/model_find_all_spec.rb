require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "queries that find all models of a specified type when models have no ancestor" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_find_1]).save
    ParentModel.new(model_data[:parent_model_find_2]).save
    ParentModel.new(model_data[:parent_model_find_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should find all models for queries from model class" do
    mods = ParentModel.find_by_model(:all)
    mods.should have_attributes_with_values([model_data[:parent_model_find_1], model_data[:parent_model_find_2], model_data[:parent_model_find_3]])
    mods.should be_class(ParentModel)
  end

end

##################################################################################################
describe "queries that find all models of a specified type when models have an ancestor" do

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

  it "should find all models and ancestor models for queries from ancestor model and return models of ancestor class" do
    mods = ParentModel.find_by_model(:all)
    mods.should have_attributes_with_values([model_data[:parent_model_find_1], model_data[:parent_model_find_2], model_data[:parent_model_find_3], model_data[:parent_child_model_find_1], model_data[:parent_child_model_find_2], model_data[:parent_child_model_find_3]])
    mods.should be_class(ParentModel)
  end

  it "should find all models for queries from model and return models of model class" do
    mods = ChildModel.find_by_model(:all)
    mods.should have_attributes_with_values([model_data[:child_model_find_1], model_data[:child_model_find_2], model_data[:child_model_find_3]])
    mods.should be_class(ChildModel)
  end

end

##################################################################################################
describe "queries that find all models of a specified type when models have an ancestor with an ancestor" do

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

  it "should find all models, ancestor models and ancestor's ancestor models for queries from ancestor's ancestor model and return models of ancestor's ancestor class" do
    mods = ParentModel.find_by_model(:all)
    mods.should have_attributes_with_values([model_data[:parent_model_find_1], model_data[:parent_model_find_2], model_data[:parent_model_find_3], model_data[:parent_child_model_find_1], model_data[:parent_child_model_find_2], model_data[:parent_child_model_find_3], model_data[:parent_grandchild_model_find_1], model_data[:parent_grandchild_model_find_2], model_data[:parent_grandchild_model_find_3]])
    mods.should be_class(ParentModel)
  end

  it "should find all models and ancestor models for queries from ancestor model and return models of ancestor class" do
    mods = ChildModel.find_by_model(:all)
    mods.should have_attributes_with_values([model_data[:child_model_find_1], model_data[:child_model_find_2], model_data[:child_model_find_3], model_data[:child_grandchild_model_find_1], model_data[:child_grandchild_model_find_2], model_data[:child_grandchild_model_find_3]])
    mods.should be_class(ChildModel)
  end

  it "should find all models for queries from model and return models of model class" do
    mods = GrandchildModel.find_by_model(:all)
    mods.should have_attributes_with_values([model_data[:grandchild_model_find_1], model_data[:grandchild_model_find_2], model_data[:grandchild_model_find_3]])
    mods.should be_class(GrandchildModel)
  end

end
