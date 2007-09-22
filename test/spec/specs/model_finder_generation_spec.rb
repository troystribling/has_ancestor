require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "automatic generation of finder methods" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should create a method find_by_attribute for queries for the first instance of a model matching a single attribute" do
    mod_before = ChildModel.find_by_parent_model_integer(model_data[:child_model_1]['parent_model_integer'])
    ChildModel.should have_method(:find_by_parent_model_integer)
    ChildModel.find_by_parent_model_integer(model_data[:child_model_1]['parent_model_integer']).should eql(mod_before)
  end

  it "should create a method find_by_attribute for queries for the all models matching a single attribute" do
    mods_before = ChildModel.find_all_by_parent_model_integer(model_data[:child_model_1]['parent_model_integer'])
    ChildModel.should have_method(:find_all_by_parent_model_integer)
    ChildModel.find_all_by_parent_model_integer(model_data[:child_model_1]['parent_model_integer']).should eql(mods_before)
  end

  it "should create a method find_by_attribute1_and_attribute2 for queries for the first instance of a model matching two attributes aggregated by logical and" do
    mod_before = ChildModel.find_by_child_model_string_and_parent_model_integer(model_data[:child_model_1]['child_model_string'], model_data[:child_model_1]['parent_model_integer'])
    ChildModel.should have_method(:find_by_child_model_string_and_parent_model_integer)
    ChildModel.find_by_child_model_string_and_parent_model_integer(model_data[:child_model_1]['child_model_string'], model_data[:child_model_1]['parent_model_integer']).should eql(mod_before)
  end

  it "should create a method find_all_by_attribute1_and_attribute2 for queries for all models matching two attributes aggregated by logical and" do
    mods_before = ChildModel.find_all_by_child_model_string_and_parent_model_integer(model_data[:child_model_1]['child_model_string'], model_data[:child_model_1]['parent_model_integer'])
    ChildModel.should have_method(:find_all_by_child_model_string_and_parent_model_integer)
    ChildModel.find_all_by_child_model_string_and_parent_model_integer(model_data[:child_model_1]['child_model_string'], model_data[:child_model_1]['parent_model_integer']).should eql(mods_before)
  end

end

