require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "implementation of instance method 'method_on_parent_model'" do

  it "should implement on parent_model" do
    ParentModel.new.should respond_to(:method_on_parent_model)
  end
  
  it "should not implement on  child_model" do
    ChildModel.new.should_not respond_to(:method_on_parent_model)
  end

  it "should not implement on  grandchild_model" do
    GrandchildModel.new.should_not respond_to(:method_on_parent_model)
  end
  
end

#########################################################################################################
describe "implementation of instance method 'method_on_descendant_child_model'" do

  it "should implement method on parent_model" do
    ParentModel.new.should respond_to(:method_on_descendant_child_model)
  end

  it "should implement on child_model" do
    ChildModel.new.should respond_to(:method_on_descendant_child_model)
  end

  it "should not implement on grandchild_model" do
    GrandchildModel.new.should_not respond_to(:method_on_descendant_child_model)
  end

end

#########################################################################################################
describe "implementation of instance method 'method_on_child_model'" do

  it "should implement method on parent_model" do
    ParentModel.new.should respond_to(:method_on_child_model)
  end

  it "should implement method on child_model" do
    ChildModel.new.should respond_to(:method_on_child_model)
  end

  it "should not implement on grandchild_model" do
    GrandchildModel.new.should_not respond_to(:method_on_child_model)
  end

end

#########################################################################################################
describe "implementation of instance method 'method_on_descendant_grandchild_model'" do

  it "should implement method on parent_model" do
    ParentModel.new.should respond_to(:method_on_descendant_grandchild_model)
  end

  it "should implement method on child_model" do
    ChildModel.new.should respond_to(:method_on_descendant_grandchild_model)
  end

  it "should implement on grandchild_model" do
    GrandchildModel.new.should respond_to(:method_on_descendant_grandchild_model)
  end

end

#########################################################################################################
describe "implementation of instance method 'method_delegation_to_ancestor'" do

  it "should implement method on parent_model" do
    ParentModel.new.should respond_to(:method_delegation_to_ancestor)
  end

  it "should implement method on child_model" do
    ChildModel.new.should respond_to(:method_delegation_to_ancestor)
  end

  it "should implement on grandchild_model" do
    GrandchildModel.new.should respond_to(:method_delegation_to_ancestor)
  end

end

#########################################################################################################
describe "implementation of instance method 'method_with_non_block_arguments'" do

  it "should implement method on parent_model" do
    ParentModel.new.should respond_to(:method_with_non_block_arguments)
  end

  it "should not implement method on child_model" do
    ChildModel.new.should_not respond_to(:method_with_non_block_arguments)
  end

  it "should implement on grandchild_model" do
    GrandchildModel.new.should respond_to(:method_with_non_block_arguments)
  end

end

#########################################################################################################
describe "implementation of instance method 'method_with_block_argument'" do

  it "should implement method on parent_model" do
    ParentModel.new.should respond_to(:method_with_block_argument)
  end

  it "should not implement method on child_model" do
    ChildModel.new.should_not respond_to(:method_with_block_argument)
  end

  it "should implement on grandchild_model" do
    GrandchildModel.new.should respond_to(:method_with_block_argument)
  end

end

#########################################################################################################
describe "implementation of instance method 'method_with_block_argument_and_non_block_argument'" do

  it "should implement method on parent_model" do
    ParentModel.new.should respond_to(:method_with_block_argument_and_non_block_argument)
  end

  it "should not implement method on child_model" do
    ChildModel.new.should_not respond_to(:method_with_block_argument_and_non_block_argument)
  end

  it "should implement on grandchild_model" do
    GrandchildModel.new.should respond_to(:method_with_block_argument_and_non_block_argument)
  end

end

#########################################################################################################
describe "implementation of class method 'method_on_parent_model'" do

  it "should implement on parent_model" do
    ParentModel.should respond_to(:method_on_parent_model)
  end
  
  it "should not implement on  child_model" do
    ChildModel.should_not respond_to(:method_on_parent_model)
  end

  it "should not implement on  grandchild_model" do
    GrandchildModel.should_not respond_to(:method_on_parent_model)
  end
  
end

#########################################################################################################
describe "implementation of class method 'method_on_child_model'" do

  it "should implement on parent_model" do
    ParentModel.should respond_to(:method_on_child_model)
  end
  
  it "should implement on  child_model" do
    ChildModel.should respond_to(:method_on_child_model)
  end

  it "should not implement on  grandchild_model" do
    GrandchildModel.should_not respond_to(:method_on_child_model)
  end
  
end

#########################################################################################################
describe "implementation of class method 'method_on_grandchild_model'" do

  it "should implement on parent_model" do
    ParentModel.should respond_to(:method_on_grandchild_model)
  end
  
  it "should implement on  child_model" do
    ChildModel.should respond_to(:method_on_grandchild_model)
  end

  it "should implement on  grandchild_model" do
    GrandchildModel.should respond_to(:method_on_grandchild_model)
  end
  
end

#########################################################################################################
describe "implementation of class method 'method_delegation_to_ancestor'" do

  it "should implement method on parent_model" do
    ParentModel.should respond_to(:method_delegation_to_ancestor)
  end

  it "should implement method on child_model" do
    ChildModel.should respond_to(:method_delegation_to_ancestor)
  end

  it "should implement on grandchild_model" do
    GrandchildModel.should respond_to(:method_delegation_to_ancestor)
  end

end

#########################################################################################################
describe "implementation of class method 'method_with_non_block_arguments'" do

  it "should implement method on parent_model" do
    ParentModel.should respond_to(:method_with_non_block_arguments)
  end

  it "should not implement method on child_model" do
    ChildModel.should_not respond_to(:method_with_non_block_arguments)
  end

  it "should not implement on grandchild_model" do
    GrandchildModel.should_not respond_to(:method_with_non_block_arguments)
  end

end

#########################################################################################################
describe "implementation of class method 'method_with_block_argument'" do

  it "should implement method on parent_model" do
    ParentModel.should respond_to(:method_with_block_argument)
  end

  it "should not implement method on child_model" do
    ChildModel.should_not respond_to(:method_with_block_argument)
  end

  it "should not implement on grandchild_model" do
    GrandchildModel.should_not respond_to(:method_with_block_argument)
  end

end

#########################################################################################################
describe "implementation of class method 'method_with_block_argument_and_non_block_argument'" do

  it "should implement method on parent_model" do
    ParentModel.should respond_to(:method_with_block_argument_and_non_block_argument)
  end

  it "should not implement method on child_model" do
    ChildModel.should_not respond_to(:method_with_block_argument_and_non_block_argument)
  end

  it "should not implement on grandchild_model" do
    GrandchildModel.should_not respond_to(:method_with_block_argument_and_non_block_argument)
  end

end

