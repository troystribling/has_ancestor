require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "descendant initialization" do

  it "should be called on construction of decsendant models" do
    ChildModel.new.descendant_init_called.should be_true 
  end

  it "should accept constructor arguments" do
    ChildModel.new(:descendant_init_called => 'not_default').descendant_init_called.should eql('not_default')
  end

  it "should ignore model initialization agruments" do
    ChildModel.new(model_data[:child_model_1]).descendant_init_called.should be_true
  end

  it "should accept arguments when model attributes are also specified" do
    ChildModel.new(:parent_model_string=>model_data[:child_model_1][':parent_model_string'], :descendant_init_called => 'not_default').descendant_init_called.should 
      eql('not_default')
  end

  it "should not prohibit initialization of model attributes" do
    ChildModel.new(:parent_model_string => model_data[:child_model_1][':parent_model_string'], :descendant_init_called => 'not_default').parent_model_string.should 
      eql(model_data[:child_model_1][':parent_model_string'])
  end

end
