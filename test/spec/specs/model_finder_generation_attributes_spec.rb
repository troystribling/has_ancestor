require File.dirname(__FILE__) + '/../spec_helper'

#################################################################################################
describe "attribute types supported by generated finder query types :first and :all for descendant models" do

  before(:all) do
    ChildModel.new(model_data[:child_model_1]).save
    ParentModel.new(model_data[:parent_model_1]).save
    ParentModel.new(model_data[:parent_model_2]).save
    ParentModel.new(model_data[:parent_model_3]).save
  end

  after(:all) do
    ParentModel.find_by_model(:all).each {|m| m.to_descendant.destroy}
  end

  it "should include :string" do
    mod = ChildModel.find_by_parent_model_string(model_data[:child_model_1]['parent_model_string'])
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :date" do
    mod = ChildModel.find_by_parent_model_date(Date.new(2007, 9, 8))
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :time" do
    mod = ChildModel.find_by_parent_model_time(Time.utc(2007, "sep", 15, 15, 55, 55))
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :datetime" do
    mod = ChildModel.find_by_parent_model_datetime(Time.utc(2007, "aug", 15, 15, 55, 55))
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :timestamp" do
    mod = ChildModel.find_by_parent_model_timestamp(Time.utc(2007, "jul", 15, 15, 55, 55))
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :integer" do
    mod = ChildModel.find_by_parent_model_integer(model_data[:child_model_1]['parent_model_integer'])
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :float" do
    mod = ChildModel.find_by_parent_model_float(1.0)
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :decimal" do
    mod = ChildModel.find_by_parent_model_decimal(2.0)
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

  it "should include :boolean" do
    mod = ChildModel.find_by_parent_model_boolean(true)
    mod.should have_attributes_with_values(model_data[:child_model_1])
    mod.should be_class(ChildModel)
  end

end

