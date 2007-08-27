require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "queries that find a all models by multible attributes where models have no ancestor" do

  before(:all) do
    ParentModel.new(model_data[:parent_model_find_1]).save
    ParentModel.new(model_data[:parent_model_find_2]).save
    ParentModel.new(model_data[:parent_model_find_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should find all models by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor of ancestor" do
  end

end

#################################################################################################
describe "queries that find a all models by multible attributes where models have an ancestor" do

  before(:all) do
    ChildModel.new(model_data[:child_model_find_1]).save
    ChildModel.new(model_data[:child_model_find_2]).save
    ChildModel.new(model_data[:child_model_find_3]).save
  end

  after(:all) do
    ChildModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should find all models by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor of ancestor" do
  end

end

#################################################################################################
describe "queries that find a all models by multible attributes where models have an ancestor with an ancestor but do not have descendants" do

  before(:all) do
    GrandchildModel.new(model_data[:grandchild_model_find_1]).save
    GrandchildModel.new(model_data[:grandchild_model_find_2]).save
    GrandchildModel.new(model_data[:grandchild_model_find_3]).save
  end

  after(:all) do
    GrandchildModel.find_by_model(:all).each {|m| m.destroy}
  end

  it "should find all models by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor of ancestor" do
    gchk = GrandchildModel.find_by_model(:all, :readonly => false, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_find_1]['grandchild_model_string']}' AND parent_models.parent_model_integer = '#{model_data[:grandchild_model_find_1]['parent_model_integer']}'")
  end

end
