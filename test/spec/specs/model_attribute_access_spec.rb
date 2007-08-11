require File.dirname(__FILE__) + '/../spec_helper'

########################################################################################################
describe "specification of attributes for a model that has descendants" do

  it "should be able to specify model attributes on creation" do
    ParentModel.new(model_data[:parent_model]).parent_model_attr.should eql(model_data[:parent_model]['parent_model_attr'])
  end

  it "should be able to specify model attributes after creation" do
    p = ParentModel.new
    p.parent_model_attr = model_data[:parent_model]['parent_model_attr']
    p.parent_model_attr.should eql(model_data[:parent_model]['parent_model_attr'])
  end

end

########################################################################################################
describe "specification of attributes for a model that has descendants and has an ancestor" do

  it "should be able to specify model attributes on creation" do
    ChildModel.new(model_data[:child_model]).child_model_attr.should eql(model_data[:child_model]['child_model_attr'])
  end

  it "should be able to specify ancestor model attributes on creation" do
    ChildModel.new(model_data[:child_model]).parent_model_attr.should eql(model_data[:child_model]['parent_model_attr'])
  end

  it "should be able to specify model attributes after creation" do
    c = ChildModel.new
    c.child_model_attr = model_data[:child_model]['child_model_attr']
    c.child_model_attr.should eql(model_data[:child_model]['child_model_attr'])
  end

  it "should be able to specify ancestor attributes after creation" do
    c = ChildModel.new
    c.parent_model_attr = model_data[:child_model]['parent_model_attr']
    c.parent_model_attr.should eql(model_data[:child_model]['parent_model_attr'])
  end

end

########################################################################################################
describe "specification of attributes for a model that has an ancestor and is a descendant of a model that has an ancestor" do

  it "should be able to specify attributes on creation" do
    GrandchildModel.new(model_data[:grandchild_model]).grandchild_model_attr.should eql(model_data[:grandchild_model]['grandchild_model_attr'])
  end

  it "should be able to specify ancestor attributes on creation" do
    GrandchildModel.new(model_data[:grandchild_model]).child_model_attr.should eql(model_data[:grandchild_model]['child_model_attr'])
  end

  it "should be able to specify ancestor's ancestor attributes on creation" do
    GrandchildModel.new(model_data[:grandchild_model]).parent_model_attr.should eql(model_data[:grandchild_model]['parent_model_attr'])
  end

  it "should be able to specify attributes after creation" do
    g = GrandchildModel.new
    g.grandchild_model_attr = model_data[:grandchild_model]['grandchild_model_attr']
    g.grandchild_model_attr.should eql(model_data[:grandchild_model]['grandchild_model_attr'])
  end

  it "should be able to specify ancestor attributes after creation" do
    g = GrandchildModel.new
    g.child_model_attr = model_data[:grandchild_model]['child_model_attr']
    g.child_model_attr.should eql(model_data[:grandchild_model]['child_model_attr'])
  end

  it "should be able to specify ancestor's ancestor attributes after creation" do
    g = GrandchildModel.new
    g.parent_model_attr = model_data[:grandchild_model]['parent_model_attr']
    g.parent_model_attr.should eql(model_data[:grandchild_model]['parent_model_attr'])
  end

end

########################################################################################################
describe "retrieval of all attributes for a model that has descendants" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should be able to retrive attributes from model instance" do
    @p.attributes.should eql_attributes(model_data[:child_ancestor_model])
  end

  it "should be able to retrive model attributes and descendant attributes from model instance" do
    @p.to_descendant.attributes.should eql_attributes(model_data[:child_model])
  end

end

########################################################################################################
describe "retrieval of all attributes for a model that has descendants and has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should be able to retrive model attributes and ancestor attributes from model instance" do
    @c.attributes.should eql_attributes(model_data[:grandchild_ancestor_model])
  end

  it "should be able to retrive model attributes, ancestor attributes and descendant from model instance" do
    @c.to_descendant.attributes.should eql_attributes(model_data[:grandchild_model])
  end

end

########################################################################################################
describe "retrieval of all attributes for a model that has an ancestor and is a descendant of a model that has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@g.parent_model_id)
  end

  after(:all) do
    @g.destroy
  end


  it "should be able to retrive model attributes, ancestor attributes and ancestor's ancestor attributes from model instance" do
    @g.attributes.should eql_attributes(model_data[:grandchild_model])
  end

  it "should be able to retrive model attributes, ancestor attributes and ancestor's ancestor attributes from ancestor model instance" do
    @c.to_descendant.attributes.should eql_attributes(model_data[:grandchild_model])
  end

  it "should be able to retrive model attributes, ancestor attributes and ancestor's ancestor attributes from ancestor's ancestor model instance" do
    @p.to_descendant.attributes.should eql_attributes(model_data[:grandchild_model])
  end

end

