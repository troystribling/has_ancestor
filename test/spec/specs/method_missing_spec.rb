require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "calls to method_missing for descendant models" do

  it "should call the instance model implementaion" do
    ChildModel.new.print_this.should eql('print_this_from_instance')
  end

  it "should call the descendant model implementaion" do
    ChildModel.print_this.should eql('print_this_from_class')
  end

end
