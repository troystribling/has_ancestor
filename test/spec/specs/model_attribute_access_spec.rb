require File.dirname(__FILE__) + '/../spec_helper'

########################################################################################################
describe "specification of attributes for a model that has no ancestor or descendants" do

  it "should be possible for model attributes on model creation" do
    ParentModel.new(model_data[:parent_model_1]).parent_model_string.should eql(model_data[:parent_model_1]['parent_model_string'])
  end

  it "should be possible for model attributes after model creation" do
    p = ParentModel.new
    p.parent_model_string = model_data[:parent_model_1]['parent_model_string']
    p.parent_model_string.should eql(model_data[:parent_model_1]['parent_model_string'])
  end

end

########################################################################################################
describe "specification of attributes for a model that has an ancestor" do

  it "should be possible for model attributes on creation" do
    ChildModel.new(model_data[:child_model_1]).child_model_string.should eql(model_data[:child_model_1]['child_model_string'])
  end

  it "should be  possible for ancestor model attributes on creation" do
    ChildModel.new(model_data[:child_model_1]).parent_model_string.should eql(model_data[:child_model_1]['parent_model_string'])
  end

  it "should be possible for model attributes after creation" do
    c = ChildModel.new
    c.child_model_string = model_data[:child_model_1]['child_model_string']
    c.child_model_string.should eql(model_data[:child_model_1]['child_model_string'])
  end

  it "should be possible for ancestor attributes after creation" do
    c = ChildModel.new
    c.parent_model_string = model_data[:child_model_1]['parent_model_string']
    c.parent_model_string.should eql(model_data[:child_model_1]['parent_model_string'])
  end

end

########################################################################################################
describe "specification of attributes for a model that has an ancestor with an ancestor" do

  it "should be possible for model attributes on creation" do
    GrandchildModel.new(model_data[:grandchild_model_1]).grandchild_model_string.should eql(model_data[:grandchild_model_1]['grandchild_model_string'])
  end

  it "should be possible for ancestor model attributes on creation" do
    GrandchildModel.new(model_data[:grandchild_model_1]).child_model_string.should eql(model_data[:grandchild_model_1]['child_model_string'])
  end

  it "should  be possible for ancestor's ancestor model attributes on creation" do
    GrandchildModel.new(model_data[:grandchild_model_1]).parent_model_string.should eql(model_data[:grandchild_model_1]['parent_model_string'])
  end

  it "should be possible for model attributes after creation" do
    g = GrandchildModel.new
    g.grandchild_model_string = model_data[:grandchild_model_1]['grandchild_model_string']
    g.grandchild_model_string.should eql(model_data[:grandchild_model_1]['grandchild_model_string'])
  end

  it "should be possible for ancestor model attributes after creation" do
    g = GrandchildModel.new
    g.child_model_string = model_data[:grandchild_model_1]['child_model_string']
    g.child_model_string.should eql(model_data[:grandchild_model_1]['child_model_string'])
  end

  it "should be possible for ancestor's ancestor attributes after creation" do
    g = GrandchildModel.new
    g.parent_model_string = model_data[:grandchild_model_1]['parent_model_string']
    g.parent_model_string.should eql(model_data[:grandchild_model_1]['parent_model_string'])
  end

end

########################################################################################################
describe "retrieval of all attributes for a model that has no ancestor" do

  before(:all) do
    @p = ParentModel.new(model_data[:parent_model_1])
  end

  it "should be able possible for model attributes from model instance" do
    @p.should have_attributes_with_values(model_data[:parent_model_1])
  end

end


########################################################################################################
describe "retrieval of all attributes for a model that has an ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_1])
  end

  it "should be able possible for model and ancestor model attributes from model instance" do
    @c.should have_attributes_with_values(model_data[:child_model_1])
  end

  it "should be able possible for ancestor model attributes from ancestor model instance" do
    @c.ancestor.should have_attributes_with_values(model_data[:parent_child_model_1])
  end

end

########################################################################################################
describe "retrieval of all attributes for a model that has an ancestor with an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
  end

  it "should be able possible for model ancestor model and ancestor's ancestor model attributes from model instance" do
    @g.should have_attributes_with_values(model_data[:grandchild_model_1])
  end

  it "should be able possible for ancestor and ancestor's ancestor model attributes from ancestor model instance" do
    @g.ancestor.should have_attributes_with_values(model_data[:child_grandchild_model_1])
  end

  it "should be able possible for ancestor's ancestor model attributes from ancestor's ancestor model instance" do
    @g.ancestor.ancestor.should have_attributes_with_values(model_data[:parent_grandchild_model_1])
  end

end

########################################################################################################
describe "retrieval of attribute column information for a model that has no ancestor" do

  it "should be able possible from model class" do
    ParentModel.columns_hash_hierarchy.keys.should have_values(model_data[:parent_model_columns])
  end

end

#########################################################################################################
describe "retrieval of attribute column information for a model that has an ancestor" do

  it "should be able possible from model class" do
    ChildModel.columns_hash_hierarchy.keys.should have_values(model_data[:child_model_columns])
  end

end

#########################################################################################################
describe "retrieval of attribute column information for a model that has an ancestor with an ancestor" do

  it "should be able possible from model class" do
    GrandchildModel.columns_hash_hierarchy.keys.should have_values(model_data[:grandchild_model_columns])
  end

end

########################################################################################################
describe "persistance of ancestor attribute class on retrieval (addresses a 'feature' found in ActiveRecord)" do

  before(:all) do
    GrandchildModel.new(model_data[:grandchild_model_1]).save
    @g = GrandchildModel.find_by_model(:first, :conditions => "grandchild_models.grandchild_model_string = '#{model_data[:grandchild_model_1]['grandchild_model_string']}'")
  end

  after(:all) do
    @g.destroy
  end

  it "should maintain :string attibute type as String for model attributes" do
    @g.grandchild_model_string.class.should eql(String)
  end

  it "should maintain :integer attibute type as Fixnum for model attributes" do
    @g.grandchild_model_integer.class.should eql(Fixnum)
  end

  it "should maintain :float attibute type as Float for model attributes" do
    @g.grandchild_model_float.class.should eql(Float)
  end

  it "should maintain :decimal attibute type as Fixnum for model attributes" do
    @g.grandchild_model_decimal.class.should eql(Fixnum)
  end
  it "should maintain :date attibute type as Date for model attributes" do
    @g.grandchild_model_date.class.should eql(Date)
  end

  it "should maintain :time attibute type as Time for model attributes" do
    @g.grandchild_model_time.class.should eql(Time)
  end

  it "should maintain :timestamp attibute type as Time for model attributes" do
    @g.grandchild_model_timestamp.class.should eql(Time)
  end

  it "should maintain :string attibute type as String for ancestor model attributes" do
    @g.child_model_string.class.should eql(String)
  end

  it "should maintain :integer attibute type as Fixnum for ancestor model attributes" do
    @g.child_model_integer.class.should eql(Fixnum)
  end

  it "should maintain :float attibute type as Float for ancestor model attributes" do
    @g.child_model_float.class.should eql(Float)
  end

  it "should maintain :decimal attibute type as Fixnum for ancestor model attributes" do
    @g.child_model_decimal.class.should eql(Fixnum)
  end
  it "should maintain :date attibute type as Date for ancestor model attributes" do
    @g.child_model_date.class.should eql(Date)
  end

  it "should maintain :time attibute type as Time for ancestor model attributes" do
    @g.child_model_time.class.should eql(Time)
  end

  it "should maintain :timestamp attibute type as Time for ancestor model attributes" do
    @g.child_model_timestamp.class.should eql(Time)
  end

  it "should maintain :datetime attibute type as Time for ancestor model attributes" do
    @g.child_model_datetime.class.should eql(Time)
  end
 
  it "should maintain :string attibute type as String for ancestor's ancestor model attributes" do
    @g.parent_model_string.class.should eql(String)
  end

  it "should maintain :integer attibute type as Fixnum for ancestor's ancestor model attributes" do
    @g.parent_model_integer.class.should eql(Fixnum)
  end

  it "should maintain :float attibute type as Float for ancestor's ancestor model attributes" do
    @g.parent_model_float.class.should eql(Float)
  end

  it "should maintain :decimal attibute type as Fixnum for ancestor's ancestor model attributes" do
    @g.parent_model_decimal.class.should eql(Fixnum)
  end

  it "should maintain :boolean attibute type as TrueClass for ancestor's ancestor model attributes" do
    @g.parent_model_boolean.class.should eql(TrueClass)
  end

  it "should maintain :date attibute type as Date for ancestor's ancestor model attributes" do
    @g.parent_model_date.class.should eql(Date)
  end

  it "should maintain :time attibute type as Time for ancestor's ancestor model attributes" do
    @g.parent_model_time.class.should eql(Time)
  end

  it "should maintain :timestamp attibute type as Time for ancestor's ancestor model attributes" do
    @g.parent_model_timestamp.class.should eql(Time)
  end

  it "should maintain :datetime attibute type as Time for ancestor's ancestor model attributes" do
    @g.parent_model_datetime.class.should eql(Time)
  end

  it "should maintain :boolean attibute type as TrueClass for ancestor model attributes" do
    @g.parent_model_boolean.class.should eql(TrueClass)
  end
  
end
