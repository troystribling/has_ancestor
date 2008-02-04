require File.dirname(__FILE__) + '/../spec_helper'

###############################################################################################
describe "determination of persistent model count when model has no ancestor" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
    ParentModel.new(model_data[:parent_model_4]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should be possible for all persistent models" do
    ParentModel.count.should eql(4)
  end

  it "should be possible when a condition is specified on a model attribute" do
    ParentModel.count(:conditions => "parent_models.parent_model_string = '#{model_data[:parent_model_1]['parent_model_string']}'").should eql(2)
  end

end

#########################################################################################################
describe "determination of persistent model count when model has an ancestor" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
    ChildModel.new(model_data[:child_model_2]).save
    ChildModel.new(model_data[:child_model_3]).save
    ChildModel.new(model_data[:child_model_4]).save
  end

  after(:all) do
    ChildModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should be possible for all persistent models" do
    ChildModel.count.should eql(4)
  end

  it "should be possible when a condition is specified on a model attribute" do
    ChildModel.count(:conditions => "child_models.child_model_string = '#{model_data[:child_model_1]['child_model_string']}'").should eql(2)
  end

  it "should be possible when a condition is specified on an ancestor model attribute" do
    ChildModel.count(:all, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_1]['parent_model_string']}'").should eql(2)
  end

end

#########################################################################################################
describe "determination of persistent model count when model has an ancestor with an ancestor" do

  before(:all) do
    GrandchildModel.new(model_data[:grandchild_model_1]).save
    GrandchildModel.new(model_data[:grandchild_model_2]).save
    GrandchildModel.new(model_data[:grandchild_model_3]).save
    GrandchildModel.new(model_data[:grandchild_model_4]).save
  end

  after(:all) do
    GrandchildModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should be possible for all persistent models" do
    GrandchildModel.count.should eql(4)
  end

  it "should be possible when a condition is specified on a model attribute" do
    GrandchildModel.count(:conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_1]['grandchild_model_string']}'").should eql(2)
  end

  it "should be possible when a condition is specified on an ancestor model attribute" do
    GrandchildModel.count(:conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_1]['child_model_string']}'").should eql(2)
  end

  it "should be possible when a condition is specified on an ancestor's ancestor model attribute" do
    GrandchildModel.count(:conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_1]['parent_model_string']}'").should eql(2)
  end

end
