require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "calls to method_missing for descendant models" do

  it "should call the instance model implementation" do
    ChildModel.new.print_this.should eql('print_this_from_instance')
  end

  it "should call the descendant model implementaion" do
    ChildModel.print_this.should eql('print_this_from_class')
  end

end

#########################################################################################################
describe "behavior for not implemented methods" do

  it "should raise NoMethodError for calls to not implemented methods on model instance" do
    lambda{ChildModel.new.this_will_fail.should raise_error(NoMethodError)}
  end

  it "should raise NoMethodError for calls to not implemented methods on model class" do
    lambda{ChildModel.this_will_fail.should raise_error(NoMethodError)}
  end

end
