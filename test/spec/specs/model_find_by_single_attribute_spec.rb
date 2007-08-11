require File.dirname(__FILE__) + '/../spec_helper'

################################################################################################
describe "database queries by single attribute for a model where model does not have an ancestor and does not have descendants" do

  before(:all) do
    @p = ParentModel.new(model_data[:parent_model])
    @p.save
  end

  after(:all) do
    @p.destroy
  end

  it "should find model by specification of model primary key" do
    ParentModel.find(@p.id).attributes.should eql_attributes(model_data[:parent_model])
  end

  it "should find model by specification of model attribute" do
    ParentModel.find_by_parent_model_attr(model_data[:parent_model]['parent_model_attr']).attributes.should \
      eql_attributes(model_data[:parent_model])
  end

end

#########################################################################################################
describe "database queries by single attribute for a model where model has descendants and does not have an ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should find model by specification of model primary key" do
    ParentModel.find(@p.id).should eql(@p)
  end

  it "should find descendant model by specification of descendant model primary key" do
    ChildModel.find(@p.descendant.id).should eql(@c)
  end

  it "should find model by specification of model attribute" do
    ParentModel.find_by_parent_model_attr(model_data[:child_model]['parent_model_attr']).should eql(@p)
  end

end

#########################################################################################################
describe "database queries by single attribute for a model where model has an ancestor and does not have descendants" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
  end

  after(:all) do
    @c.destroy
  end
    
  it "should find model by specification of model primary key" do
    ChildModel.find(@c.id).attributes.should eql_attributes(model_data[:child_model])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ParentModel.find(@c.ancestor.id).attributes.should eql_attributes(model_data[:child_ancestor_model])
  end

  it "should find model by specification of model attribute" do
    ChildModel.find_by_child_model_attr(model_data[:child_model]['child_model_attr']).should eql(@c)
  end

  it "should find model by specification of ancestor model attribute" do
    ChildModel.find_by_parent_model_attr(model_data[:child_model]['parent_model_attr']).to_descendant.should eql(@c)
  end

end


#########################################################################################################
describe "database queries by single attribute for a model where model has an ancestor and has descendants" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should find model by specification of model primary key" do
    ChildModel.find(@c.id).attributes.should eql_attributes(model_data[:grandchild_ancestor_model])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ParentModel.find(@c.ancestor.id).attributes.should \
      eql_attributes(model_data[:grandchild_ancestor_ancestor_model])
  end

  it "should find descendant model by specification of descendant model primary key" do
    GrandchildModel.find(@c.descendant.id).should eql(@g)
  end

  it "should find model by specification of model attribute" do
    ChildModel.find_by_child_model_attr(model_data[:grandchild_model]['child_model_attr']).should eql(@c)
  end

  it "should find model by specification of ancestor model attribute" do
    ChildModel.find_by_parent_model_attr(model_data[:grandchild_model]['parent_model_attr']).to_descendant(:child_model).should  eql(@c)
  end

end

#########################################################################################################
describe "database queries by single attribute for a model where model has an ancestor and is a descendant of a model that has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
  end

  after(:all) do
    @g.destroy
  end

  it "should find model by specification of model primary key" do
    GrandchildModel.find(@g.id).attributes.should eql_attributes(model_data[:grandchild_model])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ChildModel.find(@g.ancestor.id).attributes.should eql_attributes(model_data[:grandchild_ancestor_model])
  end

  it "should find ancestor's ancestor model by specification of ancestor's ancestor model primary key" do
    ParentModel.find(@g.ancestor.ancestor.id).attributes.should \
      eql_attributes(model_data[:grandchild_ancestor_ancestor_model])
  end

  it "should find model by specification of model attribute" do
    GrandchildModel.find_by_grandchild_model_attr(model_data[:grandchild_model]['grandchild_model_attr']).attributes.should \
      eql_attributes(model_data[:grandchild_model])
  end

  it "should find model by specification of ancestor model attribute" do
    GrandchildModel.find_by_child_model_attr(model_data[:grandchild_model]['child_model_attr']).to_descendant.attributes.should \
      eql_attributes(model_data[:grandchild_model])
  end

  it "should find model by specification of  ancestor's ancestor model attribute" do
    GrandchildModel.find_by_parent_model_attr(model_data[:grandchild_model]['parent_model_attr']).to_descendant.attributes.should \
      eql_attributes(model_data[:grandchild_model])
  end

end

