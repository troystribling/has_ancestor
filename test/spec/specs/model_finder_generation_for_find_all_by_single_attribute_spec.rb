require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "generated finders that find all models without an ancestor by a single attribute" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should be named 'find_all_by_attribute', match the specified model attribute and return all models as model class when called form model class " do
    mods = ParentModel.find_all_by_parent_model_string(model_data[:parent_model_1]['parent_model_string'])
    mods.should have_attributes_with_values([model_data[:parent_model_1], model_data[:parent_model_2]])
    mods.should be_class(ParentModel)
  end

end

#################################################################################################
describe "generated finders that find all models with an ancestor by a single attribute" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
    ChildModel.new(model_data[:child_model_2]).save
    ChildModel.new(model_data[:child_model_3]).save
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should be named 'find_all_by_attribute', match the specified ancestor model attribute and return all models as ancestor model class when called form ancsetor model class " do
    mods = ParentModel.find_all_by_parent_model_string(model_data[:child_model_1]['parent_model_string'])
    mods.should have_attributes_with_values([model_data[:parent_child_model_1], model_data[:parent_child_model_2]])
    mods.should be_class(ParentModel)
  end

  it "should be named 'find_all_by_attribute', match the specified ancestor model attribute and return all models as model class when called form ancsetor model class " do
    mods = ChildModel.find_all_by_parent_model_string(model_data[:child_model_1]['parent_model_string'])
    mods.should have_attributes_with_values([model_data[:child_model_1], model_data[:child_model_2]])
    mods.should be_class(ChildModel)
  end

end

#################################################################################################
describe "generated finders that find all models with an ancestor that has an ancestor by a single attribute" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
    ChildModel.new(model_data[:child_model_2]).save
    ChildModel.new(model_data[:child_model_3]).save
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
    GrandchildModel.new(model_data[:grandchild_model_1]).save
    GrandchildModel.new(model_data[:grandchild_model_2]).save
    GrandchildModel.new(model_data[:grandchild_model_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should be named 'find_all_by_attribute', match the specified ancestor's ancestor model attribute and return all models and model calss when called form model class " do
    mods = ParentModel.find_all_by_parent_model_string(model_data[:grandchild_model_1]['parent_model_string'])
    mods.should have_attributes_with_values([model_data[:parent_grandchild_model_1], model_data[:parent_grandchild_model_2]])
    mods.should be_class(ParentModel)
  end

end
