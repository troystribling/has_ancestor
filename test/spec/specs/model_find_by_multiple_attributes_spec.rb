require File.dirname(__FILE__) + '/../spec_helper'

################################ #################################################################
describe "queries that find a single model by multible attributes where model does not have an ancestor and does not have descendants" do

  before(:all) do
    @p = ParentModel.new(model_data[:parent_model_find_1])
    @p.save
  end

  after(:all) do
    @p.destroy
  end

  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
    ParentModel.find_by_model(:first, :conditions => "parent_model_string = '#{model_data[:parent_model_find_1]['parent_model_string']}' and parent_model_other_attr = #{model_data[:parent_model_find_1]['parent_model_integer']}").attributes.should \
      eql_attributes(model_data[:parent_model_find_1])
  end

end

#################################################################################################
describe "queries that find a single model by multible attributes where model where model has an ancestor and does not have descendants" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_find_1])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
    ChildModel.find_by_model(:first, :conditions => "child_model_string = '#{model_data[:child_model_find_1]['child_model_string']}' and child_model_integer = #{model_data[:child_model_find_1]['child_model_integer']}").attributes.should \
      eql_attributes(model_data[:parent_model_find_1])
  end

  it "should find model by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor" do
    ChildModel.find_by_model(:first, :conditions => "child_models.child_model_attr = '#{model_data[:child_model_find_1]['child_model_attr']}' AND parent_models.parent_model_attr = '#{model_data[:child_model_find_1]['parent_model_attr']}'").attributes.should \
      eql_attributes(model_data[:child_model_find_1])
  end

end

#################################################################################################
describe "queries that find a single model by multible attributes where model has an ancestor with an ancestor but does not have descendants" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_find_1])
    @g.save
  end

  after(:all) do
    @g.destroy
  end

  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
    GrandchildModel.find_by_model(:first, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_find_1]['grandchild_model_string']}' and grandchild_models.grandchild_model_integer = #{model_data[:grandchild_model_find_1]['grandchild_model_integer']}").attributes.should \
      eql_attributes(model_data[:grandchild_model_find_1])
  end

  it "should find model by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor of ancestor" do
    GrandchildModel.find_by_model(:first, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_find_1]['grandchild_model_string']}' AND parent_models.parent_model_integer = #{model_data[:grandchild_model_find_1]['parent_model_integer']}").attributes.should \
      eql_attributes(model_data[:grandchild_model_find_1])
  end

end
