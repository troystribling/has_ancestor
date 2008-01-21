require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "generated finders that find a model without an ancestor by a single attribute" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should be named 'find_by_attribute', match the specified model attribute and return the first model found as model class when called from model class " do
    mod = ParentModel.find_by_parent_model_string(model_data[:parent_model_3]['parent_model_string'])
    mod.should have_attributes_with_values(model_data[:parent_model_3])
    mod.should be_class(ParentModel)
  end

end

##################################################################################################
describe "generated finders that find a model with an ancestor by a single attribute" do

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

  it "should be named 'find_by_attribute', match the specified ancestor model attribute and return the first model found as ancestor model class when called from ancestor model class " do
    mod = ParentModel.find_by_parent_model_string(model_data[:child_model_3]['parent_model_string'])
    mod.should have_attributes_with_values(model_data[:parent_child_model_3])
    mod.should be_class(ParentModel)
  end

  it "should be named 'find_by_at tribute', match the specified ancestor model attribute and return the first model found as model class when called from model class " do
    mod = ChildModel.find_by_parent_model_string(model_data[:child_model_3]['parent_model_string'])
    mod.should have_attributes_with_values(model_data[:child_model_3])
    mod.should be_class(ChildModel)
  end

  it "should be named 'find_by_attribute', match the specified model attribute and return the first model found as model class when called from model class " do
    mods = ChildModel.find_by_child_model_string(model_data[:child_model_3]['child_model_string'])
    mods.should have_attributes_with_values(model_data[:child_model_3])
    mods.should be_class(ChildModel)
  end

end

##################################################################################################
describe "generated finders that find a model with an ancestor that has an ancestor by a single attribute" do

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

  it "should be named 'find_by_attribute', match the specified ancestor's ancesor model attribute and return the first model found as ancestor's ancestor model class when called from ancestor's ancestor model class " do
    mod = ParentModel.find_by_parent_model_string(model_data[:grandchild_model_3]['parent_model_string'])
    mod.should have_attributes_with_values(model_data[:parent_grandchild_model_3])
    mod.should be_class(ParentModel)
  end

  it "should be named 'find_by_attribute', match the specified ancestor's ancesor model attribute and return the first model found as ancestor model class when called from ancestor model class " do
    mod = ChildModel.find_by_parent_model_string(model_data[:grandchild_model_3]['parent_model_string'])
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_3])
    mod.should be_class(ChildModel)
  end

  it "should be named 'find_by_attribute', match the specified ancesor model attribute and return the first model found as ancestor model class when called from ancestor model class " do
    mod = ChildModel.find_by_child_model_string(model_data[:grandchild_model_3]['child_model_string'])
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_3])
    mod.should be_class(ChildModel)
  end

  it "should be named 'find_by_attribute', match the specified ancesor's ancestor model attribute and return the first model found as model class when called from model class " do
    mod = GrandchildModel.find_by_parent_model_string(model_data[:grandchild_model_3]['parent_model_string'])
    mod.should have_attributes_with_values(model_data[:grandchild_model_3])
    mod.should be_class(GrandchildModel)
  end

  it "should be named 'find_by_attribute', match the specified ancestor model attribute and return the first model found as model class when called from model class " do
    mod = GrandchildModel.find_by_child_model_string(model_data[:grandchild_model_3]['child_model_string'])
    mod.should have_attributes_with_values(model_data[:grandchild_model_3])
    mod.should be_class(GrandchildModel)
  end

  it "should be named 'find_by_attribute', match the specified model attribute and return the first model found as model class when called from model class " do
    mod = GrandchildModel.find_by_grandchild_model_string(model_data[:grandchild_model_3]['grandchild_model_string'])
    mod.should have_attributes_with_values(model_data[:grandchild_model_3])
    mod.should be_class(GrandchildModel)
  end

end

##################################################################################################
describe "generated finders that find a model with an ancestor by a single attribute with finder options with finder options that are not conditions" do

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

  it "should be named 'find_by_attribute', match the specified ancestor model attribute and return the first model found as ancestor model class when called from ancestor model class " do
    mod = ParentModel.find_by_parent_model_string(model_data[:child_model_3]['parent_model_string'], :readonly => false)
    mod.should have_attributes_with_values(model_data[:parent_child_model_3])
    mod.should be_class(ParentModel)
  end

  it "should be named 'find_by_at tribute', match the specified ancestor model attribute and return the first model found as model class when called from model class " do
    mod = ChildModel.find_by_parent_model_string(model_data[:child_model_3]['parent_model_string'], :readonly => false)
    mod.should have_attributes_with_values(model_data[:child_model_3])
    mod.should be_class(ChildModel)
  end

  it "should be named 'find_by_attribute', match the specified model attribute and return the first model found as model class when called from model class " do
    mods = ChildModel.find_by_child_model_string(model_data[:child_model_3]['child_model_string'], :readonly => false)
    mods.should have_attributes_with_values(model_data[:child_model_3])
    mods.should be_class(ChildModel)
  end

end

