require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "descendant_method_missing implementaion for descendant models" do

  it "should be called from a descendant model instance when an instance method is not implemented" do
    ChildModel.new.print_this.should eql('print_this_from_instance')
  end

  it "should be called from a descendant model class when an class method is not implemented" do
    ChildModel.print_this.should eql('print_this_from_class')
  end

end

#########################################################################################################
describe "conditions for assertion of NoMethodError for descendant models" do

  it "should raise NoMethodError for calls to not implemented methods on model instance" do
    lambda{ChildModel.new.this_will_fail.should raise_error(NoMethodError)}
  end

  it "should raise NoMethodError for calls to not implemented methods on model class" do
    lambda{ChildModel.this_will_fail.should raise_error(NoMethodError)}
  end

end
