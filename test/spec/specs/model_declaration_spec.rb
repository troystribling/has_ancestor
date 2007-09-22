require File.dirname(__FILE__) + '/../spec_helper'

########################################################################################################
describe "ancestor and descendant declarations " do

  it "should accept only the first has_ancestor call ignoring subsequent calls" do
    MultipleDeclaration.ancestor.method_defined?(:get_parent_model).should be_true 
    MultipleDeclaration.method_defined?(:get_child_model).should be_true 
    MultipleDeclaration.method_defined?(:get_grandchild_model).should be_false 
    MultipleDeclaration.class_hierarchy.should eql(['MultipleDeclaration', 'ChildModel', 'ParentModel'])
  end

  it "should accept only the first has_descendant call ignoring subsequent calls" do
  end

  it "should not be impacted by the order in which has_ancestor and has_descendants are called if both are called in a model" do
    ReverseDeclaration.class_hierarchy.should eql(['ReverseDeclaration', 'ChildModel', 'ParentModel'])
  end

end
