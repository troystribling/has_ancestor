require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "generated finders that find all models without an ancestor by multiple attributes aggregated by logical and" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
    ParentModel.new(model_data[:parent_model_4]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified model attributes and return all models found as model class when called from model class " do
    mods = ParentModel.find_all_by_parent_model_string_and_parent_model_integer(model_data[:parent_model_1]['parent_model_string'], model_data[:parent_model_1]['parent_model_integer'])
    mods.should have_attributes_with_values([model_data[:parent_model_1], model_data[:parent_model_2]])
    mods.should be_class(ParentModel)
  end

end

###################################################################################################
describe "generated finders that find all models with an ancestor by multiple attributes aggregated by logical and" do

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

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified ancestor model attributes and return all models found as ancestor model class when called from ancestor model class " do
    mods = ParentModel.find_all_by_parent_model_string_and_parent_model_integer(model_data[:child_model_1]['parent_model_string'], model_data[:child_model_1]['parent_model_integer'])
    mods.should have_attributes_with_values([model_data[:parent_child_model_1], model_data[:parent_child_model_2]])
    mods.should be_class(ParentModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified ancestor model attributes and return all models found as model class when called from model class " do
    mods = ChildModel.find_all_by_parent_model_string_and_parent_model_integer(model_data[:child_model_1]['parent_model_string'], model_data[:child_model_1]['parent_model_integer'])
    mods.should have_attributes_with_values([model_data[:child_model_1], model_data[:child_model_2]])
    mods.should be_class(ChildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match both the specified ancestor model attribute and model attribute and return all models found as model class when called from model class " do
    mods = ChildModel.find_all_by_parent_model_string_and_child_model_integer(model_data[:child_model_1]['parent_model_string'], model_data[:child_model_1]['child_model_integer'])
    mods.should have_attributes_with_values([model_data[:child_model_1], model_data[:child_model_2]])
    mods.should be_class(ChildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified model attributes and return all models found as model class when called from model class " do
    mods = ChildModel.find_all_by_child_model_string_and_child_model_integer(model_data[:child_model_1]['child_model_string'], model_data[:child_model_1]['child_model_integer'])
    mods.should have_attributes_with_values([model_data[:child_model_1], model_data[:child_model_2]])
    mods.should be_class(ChildModel)
  end

end

###################################################################################################
describe "generated finders that find all models with an ancestor that has an ancestor by multiple attributes aggregated by logical and" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
    ChildModel.new(model_data[:child_model_2]).save
    ChildModel.new(model_data[:child_model_3]).save
    ChildModel.new(model_data[:child_model_4]).save
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
    ParentModel.new(model_data[:parent_model_4]).save
    GrandchildModel.new(model_data[:grandchild_model_1]).save
    GrandchildModel.new(model_data[:grandchild_model_2]).save
    GrandchildModel.new(model_data[:grandchild_model_3]).save
    GrandchildModel.new(model_data[:grandchild_model_4]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified ancestor's ancestor model attributes and return all models found as ancestor's ancestor model class when called from ancestor's ancestor model class " do
    mods = ParentModel.find_all_by_parent_model_string_and_parent_model_integer(model_data[:grandchild_model_1]['parent_model_string'], model_data[:grandchild_model_1]['parent_model_integer'])
    mods.should have_attributes_with_values([model_data[:parent_grandchild_model_1], model_data[:parent_grandchild_model_2]])
    mods.should be_class(ParentModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified ancestor's ancestor model attributes and return all models found as ancestor model class when called from ancestor model class " do
    mods = ChildModel.find_all_by_parent_model_string_and_parent_model_integer(model_data[:grandchild_model_1]['parent_model_string'], model_data[:grandchild_model_1]['parent_model_integer'])
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_1], model_data[:child_grandchild_model_2]])
    mods.should be_class(ChildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match both the specified ancestor's ancestor model attribute and ancestor model attribute and return all models found as ancestor model class when called from ancestor model class " do
    mods = ChildModel.find_all_by_parent_model_string_and_child_model_integer(model_data[:grandchild_model_1]['parent_model_string'], model_data[:grandchild_model_1]['child_model_integer'])
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_1], model_data[:child_grandchild_model_2]])
    mods.should be_class(ChildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified ancestor model attributes and return all models found as ancestor model class when called from ancestor model class " do
    mods = ChildModel.find_all_by_child_model_string_and_child_model_integer(model_data[:grandchild_model_1]['child_model_string'], model_data[:grandchild_model_1]['child_model_integer'])
    mods.should have_attributes_with_values([model_data[:child_grandchild_model_1], model_data[:child_grandchild_model_2]])
    mods.should be_class(ChildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified ancestor model attributes and return all models found as model class when called from model class " do
    mods = GrandchildModel.find_all_by_parent_model_string_and_parent_model_integer(model_data[:grandchild_model_1]['parent_model_string'], model_data[:grandchild_model_1]['parent_model_integer'])
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]])
    mods.should be_class(GrandchildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match both the specified ancestor model attribute and model attribute and return all models found as model class when called from model class " do
    mods = GrandchildModel.find_all_by_parent_model_string_and_child_model_integer(model_data[:grandchild_model_1]['parent_model_string'], model_data[:grandchild_model_1]['child_model_integer'])
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]])
    mods.should be_class(GrandchildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match both the specified ancestor model attribute and model attribute and return all models found as model class when called from model class " do
    mods = GrandchildModel.find_all_by_child_model_string_and_child_model_integer(model_data[:grandchild_model_1]['child_model_string'], model_data[:grandchild_model_1]['child_model_integer'])
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]])
    mods.should be_class(GrandchildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match both the specified ancestor's ancestor model attribute and model attribute and return all models found as model class when called from model class " do
    mods = GrandchildModel.find_all_by_parent_model_string_and_grandchild_model_integer(model_data[:grandchild_model_1]['parent_model_string'], model_data[:grandchild_model_1]['grandchild_model_integer'])
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]])
    mods.should be_class(GrandchildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match both the specified ancestor model attribute and model attribute and return all models found as model class when called from model class " do
    mods = GrandchildModel.find_all_by_child_model_string_and_grandchild_model_integer(model_data[:grandchild_model_1]['child_model_string'], model_data[:grandchild_model_1]['grandchild_model_integer'])
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]])
    mods.should be_class(GrandchildModel)
  end

  it "should be named 'find_all_by_attribute1_and_attribute2', match the specified model attributes and return all models found as model class when called from model class " do
    mods = GrandchildModel.find_all_by_grandchild_model_string_and_grandchild_model_integer(model_data[:grandchild_model_1]['grandchild_model_string'], model_data[:grandchild_model_1]['grandchild_model_integer'])
    mods.should have_attributes_with_values([model_data[:grandchild_model_1], model_data[:grandchild_model_2]])
    mods.should be_class(GrandchildModel)
  end

end
