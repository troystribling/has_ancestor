require File.dirname(__FILE__) + '/../spec_helper'

################################################################################################
describe "queries by single attribute for a model of a specified type when model does not have an ancestor" do

  before(:all) do
    @p = ParentModel.new(model_data[:parent_model_find_1])
    @p.save
  end

  after(:all) do
    @p.destroy
  end

  it "should find model by specification of model primary key and return model class for queries from model class" do
    mod = ParentModel.find_by_model(@p.id)
    mod.should have_attributes_with_values(model_data[:parent_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find first model and return model class for queries from model class" do
    mod = ParentModel.find_by_model(:first)
    mod.should have_attributes_with_values(model_data[:parent_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find first model that matches specified model attribute and return model class for queries from model class" do
    mod = ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:parent_model_find_1]['parent_model_string']}'")
    mod.should have_attributes_with_values(model_data[:parent_model_find_1])
    mod.should be_class(ParentModel)
  end

end

#########################################################################################################
describe "queries by single attribute for a model of a specified type when model has an ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_find_1])
    @c.save
    @p = ParentModel.find_by_model(:first)
  end

  after(:all) do
    @c.destroy
  end

  it "should find ancestor model by specification of ancestor model primary key and return ancestor model class for queries from ancestor model class" do
    mod = ParentModel.find_by_model(@p.id)
    mod.should have_attributes_with_values(model_data[:parent_child_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find model by specification of model primary key and return model class for queries from model class" do
    mod = ChildModel.find_by_model(@c.id)
    mod.should have_attributes_with_values(model_data[:child_model_find_1])
    mod.should be_class(ChildModel)
  end

  it "should find first ancestor model and return ancestor model class for queries from ancestor model class" do
    mod = ParentModel.find_by_model(:first)
    mod.should have_attributes_with_values(model_data[:parent_child_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find first model and return model class for queries from model class" do
    mod = ChildModel.find_by_model(:first)
    mod.should have_attributes_with_values(model_data[:child_model_find_1])
    mod.should be_class(ChildModel)
  end

  it "should find first ancestor model that matches specified ancestor model attribute and return ancestor model class for queries from ancestor model class" do
    mod = ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_find_1]['parent_model_string']}'")
    mod.should have_attributes_with_values(model_data[:parent_child_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find first model that matches specified ancestor model attribute and return model class for queries from model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:child_model_find_1]['parent_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_model_find_1])
    mod.should be_class(ChildModel)
  end

  it "should find first model that matches specified model attribute and return model class for queries from model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "child_models.child_model_string = '#{model_data[:child_model_find_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_model_find_1])
    mod.should be_class(ChildModel)
  end

end

#########################################################################################################
describe "queries by single attribute for a model of a specified type when model has an ancestor with an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_find_1])
    @g.save
    @c = ChildModel.find_by_model(:first)
    @p = ParentModel.find_by_model(:first)
  end

  after(:all) do
    @g.destroy
  end

  it "should find ancestor's ancestor model by specification of ancestor's ancestor model primary key and return ancestor's ancestor model class for queries from ancestor's ancestor model class" do
    mod = ParentModel.find_by_model(@p.id)
    mod.should have_attributes_with_values(model_data[:parent_grandchild_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find ancestor model by specification of ancestor model primary key and return ancestor model class for queries from ancestor model class" do
    mod = ChildModel.find_by_model(@c.id)
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_find_1])
    mod.should be_class(ChildModel)
  end

  it "should find model by specification of model primary key and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(@g.id)
    mod.should have_attributes_with_values(model_data[:grandchild_model_find_1])
    mod.should be_class(GrandchildModel)
  end

  it "should find first ancestor's ancestor model and return ancestor's ancestor model class for queries from ancestor's ancestor model class" do
    mod = ParentModel.find_by_model(:first)
    mod.should have_attributes_with_values(model_data[:parent_grandchild_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find first ancestor model and return ancestor model class for queries from ancestor model class" do
    mod = ChildModel.find_by_model(:first)
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_find_1])
    mod.should be_class(ChildModel)
  end

  it "should find first model and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first)
    mod.should have_attributes_with_values(model_data[:grandchild_model_find_1])
    mod.should be_class(GrandchildModel)
  end

  it "should find first ancestor's ancestor model that matches specified ancestor's ancestor model attribute and return ancestor's ancestor model class for queries from ancestor's ancestor model class" do
    mod = ParentModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_find_1]['parent_model_string']}'")
    mod.should have_attributes_with_values(model_data[:parent_grandchild_model_find_1])
    mod.should be_class(ParentModel)
  end

  it "should find first ancestor model that matches specified ancestor's ancestor model attribute and return ancestor model class for queries from ancestor model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_find_1]['parent_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_find_1])
    mod.should be_class(ChildModel)
  end

  it "should find first ancestor model that matches specified ancestor model attribute and return ancestor model class for queries from ancestor model class" do
    mod = ChildModel.find_by_model(:first, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_find_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:child_grandchild_model_find_1])
    mod.should be_class(ChildModel)
  end

  it "should find first model that matches specified ancestor's ancestor model attribute and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "parent_models.parent_model_string = '#{model_data[:grandchild_model_find_1]['parent_model_string']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_find_1])
    mod.should be_class(GrandchildModel)
  end

  it "should find first model that matches specified ancestor model attribute and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "child_models.child_model_string = '#{model_data[:grandchild_model_find_1]['child_model_string']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_find_1])
    mod.should be_class(GrandchildModel)
  end

  it "should find first model that matches specified model attribute and return model class for queries from model class" do
    mod = GrandchildModel.find_by_model(:first, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_find_1]['grandchild_model_string']}'")
    mod.should have_attributes_with_values(model_data[:grandchild_model_find_1])
    mod.should be_class(GrandchildModel)
  end

end
