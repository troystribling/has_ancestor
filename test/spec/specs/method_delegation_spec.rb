require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
# instance method specifications
#########################################################################################################
describe "delegation of instance method call for a model that has no descendants and has no ancestor" do

  before(:all) do
    @p = ParentModel.new(model_data[:parent_model])
  end

  it "should call the method on the model" do
    @p.method_on_parent_model.should eql(model_data[:parent_model]['parent_model_attr'])
  end

end

#########################################################################################################
describe "delegation of instance method call for a model that has descendants and has no ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should call the method on the model when the method is implemented on the model" do
    @p.method_on_parent_model.should eql(model_data[:child_model]['parent_model_attr'])
  end

  it "should call the method on the model when the method is implemented on the descendant model" do
    @p.method_on_descendant_child_model.should eql(model_data[:child_model]['parent_model_attr'])
  end

end

#########################################################################################################
describe "delegation of instance method call for a model that has no descendants and has an ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should call the method on the model when the method is implemented on the model" do
    @c.method_on_child_model.should eql(model_data[:child_model]['child_model_attr'])
  end

  it "should call the method on the ancestor model when the method is not implemented on the model" do
    @c.method_on_parent_model.should eql(model_data[:child_model]['parent_model_attr'])
  end

end

#########################################################################################################
describe "delegation of instance method call for a model that has descendants and has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should call the method on the model when the method is implemented on the model" do
    @c.method_on_child_model.should eql(model_data[:grandchild_model]['child_model_attr'])
  end

  it "should call the method on the ancestor model when the method is implemented only on the ancestor" do
    @c.method_on_parent_model.should eql(model_data[:grandchild_model]['parent_model_attr'])
  end

  it "should call the method on the model when the method is implemented on the descendant model" do
    @c.method_on_descendant_grandchild_model.should eql(model_data[:grandchild_model]['child_model_attr'])
  end

end

#########################################################################################################
describe "delegation of instance method call that delgates calls to its ancestor in the method implementation" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should call the method implementations in model and ancestor when called from model with a single ancestor" do
    expected_method_result = "#{model_data[:grandchild_model]['child_model_attr']}:#{model_data[:grandchild_model]['parent_model_attr']}"
    @c.method_delegation_to_ancestor.should be_eql(expected_method_result)
  end

  it "should call the method implementations on model and an all ancestors when called from model with an ancestor that has an ancestor" do
    expected_method_result = "#{model_data[:grandchild_model]['grandchild_model_attr']}:#{model_data[:grandchild_model]['child_model_attr']}:#{model_data[:grandchild_model]['parent_model_attr']}"
    @g.method_delegation_to_ancestor.should be_eql(expected_method_result)
  end

end

#########################################################################################################
describe "delgated instance method call with an implementations that takes arguments" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should be possible to implement delegated methods that take non-block arguments" do
    expected_method_result = "#{model_data[:grandchild_model]['parent_model_attr']}:the_argument"
    @c.method_with_non_block_arguments(:argument=>'the_argument').should be_eql(expected_method_result)
  end

  it "should be possible to implement delegated methods that take block arguments" do
    method_result = @c.method_with_block_argument do |s|
      s.class.name
    end
    expected_method_result = 'ChildModel'    
    method_result.should be_eql(expected_method_result)
  end

  it "should be possible to implement delegated methods that take both non-block and block arguments" do
    method_result = @c.method_with_block_argument_and_non_block_argument(:argument=>'the_argument') do |a, s|
      "#{a[:argument]}:#{s.class.name}"
    end
    expected_method_result = 'the_argument:ChildModel'    
    method_result.should be_eql(expected_method_result)
  end

end

#########################################################################################################
# class method specifications
#########################################################################################################
describe "delegation of class method call for a model that has no descendants and has no ancestor" do

  it "should call the method on the model" do
    ParentModel.method_on_parent_model.should eql('method_on_parent_model')
  end

end

#########################################################################################################
describe "delegation of class method call for a model that has descendants and has an ancestor" do

  it "should call the method on the model when the method is implemented on the model" do
    ChildModel.method_on_parent_model.should eql('method_on_parent_model')
  end

  it "should call the method on the model when the method is implemented on the descendant model" do
    ChildModel.method_on_child_model.should eql('method_on_child_model')
  end

end

#########################################################################################################
describe "delegation of class method call for a model that has no descendants and has an ancestor that has an ancestor" do

  it "should call the method on the model when the method is implemented on the model" do
    GrandchildModel.method_on_parent_model.should eql('method_on_parent_model')
  end

  it "should call the method on the ancestor model when the method is implemented on the ancestor and ancestor's ancestor" do
    GrandchildModel.method_on_child_model.should eql('method_on_child_model')
  end

  it "should call the method on the model when the method is implemented on the descendant model" do
    GrandchildModel.method_on_grandchild_model.should eql('method_on_grandchild_model')
  end

end

#########################################################################################################
describe "implementation of class method 'method_delegation_to_ancestor'" do

  it "should call the method implementations in model and ancestor when called from model with an ancestor" do
    expected_method_result = 'method_on_child_model:method_on_parent_model'
    ChildModel.method_delegation_to_ancestor.should be_eql(expected_method_result)
  end

  it "should call the method implementations on model and an all ancestors when called from model with an ancestor that has an ancestor" do
    expected_method_result = 'method_on_grandchild_model:method_on_child_model:method_on_parent_model'
    GrandchildModel.method_delegation_to_ancestor.should be_eql(expected_method_result)
  end

end

#########################################################################################################
describe "delgated class method call with an implementaion that takes arguments" do

  it "should be possible to implement delegated methods that take non-block arguments" do
    expected_method_result = 'method_on_parent_model:the_argument'
    GrandchildModel.method_with_non_block_arguments(:argument=>'the_argument').should be_eql(expected_method_result)
  end

  it "should be possible to implement delegated methods that take block arguments" do
    method_result = GrandchildModel.method_with_block_argument do |s|
      s.name
    end
    expected_method_result = 'ParentModel'    
    method_result.should be_eql(expected_method_result)
  end

  it "should be possible to implement delegated methods that take both non-block and block arguments" do
    method_result = GrandchildModel.method_with_block_argument_and_non_block_argument(:argument=>'the_argument') do |a, s|
      "#{a[:argument]}:#{s.name}"
    end
    expected_method_result = 'the_argument:ParentModel'    
    method_result.should be_eql(expected_method_result)
  end

end

