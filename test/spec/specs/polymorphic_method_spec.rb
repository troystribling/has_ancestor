require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "call of a polymorphic method from a model instance that has no descendants and has no ancestor" do

  before(:all) do
    @p = ParentModel.new(model_data['PARENT_MODEL'])
  end

  it "should call the method on the model" do
    @p.to_descendant.method_on_parent_model.should eql(model_data['PARENT_MODEL']['parent_model_attr'])
  end

end

#########################################################################################################
describe "call of a polymorphic method from a model instance that has descendants and has no ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should call the method on the model when the method is implemented only on the model" do
    @p.to_descendant.method_on_parent_model.should be_eql(model_data['CHILD_MODEL']['parent_model_attr'])
  end

  it "should call the method on the descendant model when the method is implemented on the descendant model" do
    @p.to_descendant.method_on_descendant_child_model.should be_eql(model_data['CHILD_MODEL']['child_model_attr'])
  end

end

#########################################################################################################
describe "call of a polymorphic method from a model instance that has no descendants and has an ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should call the method on the model when the method is implemented on the model" do
    @c.to_descendant.method_on_child_model.should be_eql(model_data['CHILD_MODEL']['child_model_attr'])
  end

  it "should call the method on the ancestor model when the method is not implemented on the model" do
    @c.to_descendant.method_on_parent_model.should be_eql(model_data['CHILD_MODEL']['parent_model_attr'])
  end

end

#########################################################################################################
describe "call of a polymorphic method from a model instance that has descendants and has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should call the method on the model when the method is implemented on the model and not on the descendant" do
    @c.to_descendant.method_on_child_model.should be_eql(model_data['GRANDCHILD_MODEL']['child_model_attr'])
  end

  it "should call the method on the ancestor model when the method is implemented only on the ancestor" do
    @c.to_descendant.method_on_parent_model.should be_eql(model_data['GRANDCHILD_MODEL']['parent_model_attr'])
  end

  it "should call the method on the descendant model when the method is implemented on the descendant model" do
    @c.to_descendant.method_on_descendant_grandchild_model.should be_eql(model_data['GRANDCHILD_MODEL']['grandchild_model_attr'])
  end

end

#########################################################################################################
describe "call of a polymorphic method, from a model instance that has descendants, that delgates calls to its ancestor in the method implementation " do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should call the method on the the leaf and every other implemenation in the hirarchy if all implemenations delegate to their ancestor" do
    expected_method_result = "#{model_data['GRANDCHILD_MODEL']['grandchild_model_attr']}:#{model_data['GRANDCHILD_MODEL']['child_model_attr']}:#{model_data['GRANDCHILD_MODEL']['parent_model_attr']}"
    @p.to_descendant.method_delegation_to_ancestor.should be_eql(expected_method_result)
  end

end

#########################################################################################################
describe "call of a polymorphic method from a model instance with an implementation that takes arguments" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save
    @c = ChildModel.find(@g.child_model_id)
    @p = ParentModel.find(@g.parent_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should be possible to implement polymorphic methods that take non-block arguments" do
    expected_method_result = "#{model_data['GRANDCHILD_MODEL']['grandchild_model_attr']}:the_argument"
    @p.to_descendant.method_with_non_block_arguments(:argument=>'the_argument').should be_eql(expected_method_result)
  end

  it "should be possible to implement polymorphic methods that take block arguments" do
    method_result = @p.to_descendant.method_with_block_argument do |s|
      s.class.name
    end
    expected_method_result = 'GrandchildModel'    
    method_result.should be_eql(expected_method_result)
  end

  it "should be possible to implement polymorphic methods that take both non-block and block arguments" do
    method_result = @p.to_descendant.method_with_block_argument_and_non_block_argument(:argument=>'the_argument') do |a, s|
      "#{a[:argument]}:#{s.class.name}"
    end
    expected_method_result = 'the_argument:GrandchildModel'    
    method_result.should be_eql(expected_method_result)
  end

end
