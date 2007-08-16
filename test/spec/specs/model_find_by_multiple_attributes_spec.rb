require File.dirname(__FILE__) + '/../spec_helper'

################################ #################################################################
describe "database queries by multible attributes for a model where model does not have an ancestor and does not have descendants" do

  before(:all) do
    @p = ParentModel.new(model_data[:parent_model_multiple_find])
    @p.save
  end

  after(:all) do
    @p.destroy
  end

  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
    ParentModel.find_model(:first, :conditions => "parent_model_attr = '#{model_data[:parent_model_multiple_find]['parent_model_attr']}' and parent_model_other_attr = '#{model_data[:parent_model_multiple_find]['parent_model_other_attr']}'").attributes.should \
      eql_attributes(model_data[:parent_model_multiple_find])
  end

  it "should find model with generated finder which uses mutiple model attribute match condition where all attributes belong to model" do
    ParentModel.find_by_parent_model_attr_and_parent_model_other_attr(model_data[:parent_model_multiple_find]['parent_model_attr'], model_data[:parent_model_multiple_find]['parent_model_other_attr']).attributes.should \
      eql_attributes(model_data[:parent_model_multiple_find])
  end

end

#################################################################################################
describe "database queries by multible attributes for a model where model has an ancestor and does not have descendants" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_multiple_find])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
    ChildModel.find_model(:first, :conditions => "child_model_attr = '#{model_data[:child_model_multiple_find]['child_model_attr']}' and child_model_other_attr = '#{model_data[:child_model_multiple_find]['child_model_other_attr']}'").attributes.should \
      eql_attributes(model_data[:child_model_multiple_find])
  end

  it "should find model by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor" do
    ChildModel.find_model(:first, :conditions => "child_models.child_model_attr = '#{model_data[:child_model_multiple_find]['child_model_attr']}' AND parent_models.parent_model_attr = '#{model_data[:child_model_multiple_find]['parent_model_attr']}'").attributes.should \
      eql_attributes(model_data[:child_model_multiple_find])
  end

end

#################################################################################################
describe "database queries by multible attributes for a model where model has an ancestor and ancestor has ancestor but does not have descendants" do

  before(:all) do
    @g1 = GrandchildModel.new(model_data[:grandchild_model_multiple_find])
    @g1.save
    @g2 = GrandchildModel.new(model_data[:grandchild_model_multiple_find_1])
    @g2.save
    @g3 = GrandchildModel.new(model_data[:grandchild_model_multiple_find_2])
    @g3.save
  end

  after(:all) do
    @g1.destroy
    @g2.destroy
    @g3.destroy
  end

  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
    GrandchildModel.find_model(:first, :conditions => "grandchild_model_attr = '#{model_data[:grandchild_model_multiple_find]['grandchild_model_attr']}' and grandchild_model_other_attr = '#{model_data[:grandchild_model_multiple_find]['grandchild_model_other_attr']}'").attributes.should \
      eql_attributes(model_data[:grandchild_model_multiple_find])
  end

  it "should find model by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor of ancestor" do
    GrandchildModel.find_model(:first, :conditions => "grandchild_models.grandchild_model_attr = '#{model_data[:grandchild_model_multiple_find]['grandchild_model_attr']}' AND parent_models.parent_model_attr = '#{model_data[:grandchild_model_multiple_find]['parent_model_attr']}'").attributes.should \
      eql_attributes(model_data[:grandchild_model_multiple_find])
  end

  it "should find all models by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor of ancestor" do
    gchk = GrandchildModel.find_model(:all, :readonly => false, :conditions => "grandchild_models.grandchild_model_attr = '#{model_data[:grandchild_model_multiple_find]['grandchild_model_attr']}' AND parent_models.parent_model_attr = '#{model_data[:grandchild_model_multiple_find]['parent_model_attr']}'")
#      gchk.attributes.should eql_attributes(model_data[:grandchild_model_multiple_find])
  end

end
