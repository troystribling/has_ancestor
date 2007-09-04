require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "retrieval of descendant model from ancestor model instance when descendent is leaf in inheritance hierarchy" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_1])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should return descendant model when request has no target model specified" do
    @p.to_descendant.should eql(@c)
  end

  it "should return descendant model when request has descendant specified as traget model" do
    @p.to_descendant(:child_model).should eql(@c)
  end

end

#########################################################################################################
describe "retrieval of descendant model from its own instance when model has no descendants or ancestors" do

  before(:all) do
    @p = ParentModel.new(model_data[:parent_model_1])
    @p.save
  end

  after(:all) do
    @p.destroy
  end

  it "should return itself when request has no target model specified" do
    @p.to_descendant.should eql(@p)
  end

  it "should return itself when request has model specified as target model" do
    @p.to_descendant(:parent_model).should eql(@p)
  end

end


#########################################################################################################
describe "retrieval of descendant model from own instance  when descendant is leaf in inheritance hierarchy" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_1])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

  it "should return itself when request has no target model specified" do
    @c.to_descendant.should be_eql(@c)
  end

  it "should return itself when request has model specified as target model" do
    @c.to_descendant(:child_model).should be_eql(@c)
  end

end

#########################################################################################################
describe "retrieval of descendant model from own instance when descendant is not leaf in inheritance hierarchy" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should return itself when when request model specified as traget model" do
    @c.to_descendant(:child_model).should be_eql(@c)
  end

end


#########################################################################################################
describe "retrieval of descendant model from ancestor's ancestor model instance when descendant is leaf in inheritance hierarchy" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should return leaf descendant model when request has no target model specified" do
    @p.to_descendant.should be_eql(@g)
  end

  it "should return descendant model when request has descendant specified as target model" do
    @p.to_descendant(:grandchild_model).should be_eql(@g)
  end

  it "should return ancestor model when request has ancestor specified as target model" do
    @p.to_descendant(:child_model).should be_eql(@c)
  end

end

#########################################################################################################
describe "error conditions resulting from retrieval of descendant model from ancestor model instance" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should raise an exception when target model is not in the inheritance hierarchy with ancestor as root" do
    lambda {@p.to_descendant(:this_will_fail)}.should raise_error(PlanB::InvalidType)
  end

end

