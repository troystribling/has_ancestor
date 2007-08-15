require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "discovery of descendant model from model instance" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

  it "should be possible if model has descendants is not a leaf in inheritance hierarchy" do
    ParentModel.find(@c.parent_model_id).descendant.should eql(@c)
  end

  it "should be nil if model has descendants but is a leaf in inheritance hierarchy" do
    @c.descendant.should be_nil
  end

  it "should be nil if model does not have descendants" do
    ParentModel.new(model_data[:parent_model]).descendant.should be_nil
  end

end

########################################################################################################
describe "discovery of ancestor model from model instance" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

  it "should be possible if model has an ancestor" do
   @c.ancestor.should be_eql(ParentModel.find(@c.parent_model_id))
  end

  it "should be nill if model does not have an ancestor" do
    ParentModel.find(@c.parent_model_id).ancestor.should be_nil
  end

end

########################################################################################################
describe "discovery of ancestor class from model class" do

  it "should be possible if model has an ancestor" do
   ParentModel.ancestor.should be_nil
  end

  it "should be nill if model does not have an ancestor" do
    ChildModel.ancestor.should be_eql(ParentModel)
  end

end

########################################################################################################
describe "validation from model instance of model ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
  end

  it "should be able to determine if immediate ancestor is of a specified class" do
    @g.should be_descendant_of(:child_model)
  end

  it "should be able to determine if immediate ancestor's ancestor is of a specified class" do
    @g.should be_descendant_of(:parent_model)
  end

  it "should raise exception if model specified is not an ancestor" do
    @g.should_not be_descendant_of(:this_will_fail)
  end
  
  it "should raise exception if model has no ancestor" do
    ParentModel.new(model_data[:parent_model]).should_not be_descendant_of(:this_will_fail)
  end
  
end

########################################################################################################
describe "discovery from model instance of model inheritance hierarchy" do

  it "should return model if model has no ancestors" do
    ParentModel.new(model_data[:parent_model]).class_hierarchy.should eql(['ParentModel'])
  end

  it "should be able to determine the class of all ancestors for model that has ancestors" do
    GrandchildModel.new(model_data[:grandchild_model]).class_hierarchy.should eql(['GrandchildModel', 'ChildModel', 'ParentModel'])
  end

end

########################################################################################################
describe "discovery from model class of model inheritance hierarchy" do

  it "should return model if model has no ancestors" do
    ParentModel.class_hierarchy.should eql(['ParentModel'])
  end

  it "should be able to determine the class of all ancestors for model that has ancestors" do
    GrandchildModel.class_hierarchy.should eql(['GrandchildModel', 'ChildModel', 'ParentModel'])
  end

end

