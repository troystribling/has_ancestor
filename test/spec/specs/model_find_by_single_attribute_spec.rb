require File.dirname(__FILE__) + '/../spec_helper'

################################################################################################
describe "queries by single attribute for a model where model does not have an ancestor and does not have descendants" do

  before(:all) do
    ParentModel.new(model_data[:parent_model]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find model by specification of model primary key" do
    ParentModel.find_by_model(@p.id).attributes.should eql_attributes(model_data[:parent_model])
  end

  it "should find first model" do
    ParentModel.find_by_model(:first).attributes.should eql_attributes(model_data[:parent_model])
  end

  it "should find model by specification of model attribute" do
    ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_attr = '#{model_data[:parent_model]['parent_model_attr']}'").attributes.should \
      eql_attributes(model_data[:parent_model])
  end

end

#########################################################################################################
describe "queries by single attribute for a model where model has descendants and does not have an ancestor" do

  before(:all) do
    ChildModel.new(model_data[:child_model]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find model by specification of model primary key" do
    ParentModel.find_by_model(@p.id).should eql(@p)
  end

  it "should find descendant model by specification of descendant model primary key" do
    ChildModel.find_by_model(@p.descendant.id).should eql(@c)
  end

  it "should find model by specification of model attribute" do
    ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_attr = '#{model_data[:child_model]['parent_model_attr']}'").should eql(@p)
  end

end

#########################################################################################################
describe "queries by single attribute for a model where model has an ancestor and does not have descendants" do

  before(:all) do
    ChildModel.new(model_data[:child_model]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end
    
  it "should find model by specification of model primary key" do
    ChildModel.find_by_model(@c.id).attributes.should eql_attributes(model_data[:child_model])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ParentModel.find_by_model(@c.ancestor.id).attributes.should eql_attributes(model_data[:child_ancestor_model])
  end

  it "should find model by specification of model attribute" do
    ChildModel.find_by_model(:first, :conditions => "child_models.child_model_attr = '#{model_data[:child_model]['child_model_attr']}'").should eql(@c)
  end

  it "should find model by specification of ancestor model attribute" do
    ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_attr = '#{model_data[:child_model]['parent_model_attr']}'").should eql(@c)
  end

end


#########################################################################################################
describe "queries by single attribute for a model where model has an ancestor and has descendants" do

  before(:all) do
    GrandchildModel.new(model_data[:grandchild_model]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find model by specification of model primary key" do
    ChildModel.find_by_model(@c.id).attributes.should eql_attributes(model_data[:grandchild_ancestor_model])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ParentModel.find_by_model(@c.ancestor.id).attributes.should \
      eql_attributes(model_data[:grandchild_ancestor_ancestor_model])
  end

  it "should find descendant model by specification of descendant model primary key" do
    GrandchildModel.find_by_model(@c.descendant.id).should eql(@g)
  end

  it "should find model by specification of model attribute" do
    ChildModel.find_by_model(:first, :conditions => "child_models.child_model_attr = '#{model_data[:grandchild_model]['child_model_attr']}'").should eql(@c)
  end

  it "should find model by specification of ancestor model attribute" do
    ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_attr = '#{model_data[:grandchild_model]['parent_model_attr']}'").should  eql(@c)
  end

end

#########################################################################################################
describe "queries by single attribute for a model where model has an ancestor and is a descendant of a model that has an ancestor" do

  before(:all) do
    GrandchildModel.new(model_data[:grandchild_model]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should find model by specification of model primary key" do
    GrandchildModel.find_by_model(@g.id).attributes.should eql_attributes(model_data[:grandchild_model])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ChildModel.find_by_model(@g.ancestor.id).attributes.should eql_attributes(model_data[:grandchild_ancestor_model])
  end

  it "should find ancestor's ancestor model by specification of ancestor's ancestor model primary key" do
    ParentModel.find_by_model(@g.ancestor.ancestor.id).attributes.should \
      eql_attributes(model_data[:grandchild_ancestor_ancestor_model])
  end

  it "should find model by specification of model attribute" do
    GrandchildModel.find_by_model(:first, :conditions => "grandchild_models.grandchild_model_attr = '#{model_data[:grandchild_model]['grandchild_model_attr']}'").attributes.should \
      eql_attributes(model_data[:grandchild_model])
  end

  it "should find model by specification of ancestor model attribute" do
    GrandchildModel.find_by_model(:first, :conditions => "child_models.child_model_attr = '#{model_data[:grandchild_model]['child_model_attr']}'").attributes.should \
      eql_attributes(model_data[:grandchild_model])
  end

  it "should find model by specification of  ancestor's ancestor model attribute" do
    GrandchildModel.find_by_model(:first, :conditions => "parent_models.parent_model_attr = '#{model_data[:grandchild_model]['parent_model_attr']}'").attributes.should \
      eql_attributes(model_data[:grandchild_model])
  end

end

