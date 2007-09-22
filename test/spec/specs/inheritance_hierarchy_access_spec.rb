require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "discovery of descendant model from model instance" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_1])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

  it "should be possible if model has descendants is not a leaf in inheritance hierarchy" do
    ParentModel.find(@c.parent_model_id).descendant.should eql(@c)
  end

  it "should be nil if model has descendants but is a leaf in inheritance hierarchy" do
    @c.descendant.should be_nil
  end

  it "should be nil if model does not have descendants" do
    ParentModel.new(model_data[:parent_model_1]).descendant.should be_nil
  end

end

########################################################################################################
describe "discovery of ancestor model from model instance" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_1])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

  it "should be possible if model has an ancestor" do
   @c.ancestor.should be_eql(ParentModel.find(@c.parent_model_id))
  end

  it "should be nill if model does not have an ancestor" do
    ParentModel.find(@c.parent_model_id).ancestor.should be_nil
  end

end

########################################################################################################
describe "discovery of ancestor class from model class" do

  it "should be nill if model does not have an ancestor" do
   ParentModel.ancestor.should be_nil
  end

  it "should be possible if model has an ancestor" do
    ChildModel.ancestor.should be_eql(ParentModel)
  end

end

########################################################################################################
describe "validation from model instance of inheritance hierarchy" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
    @c = ChildModel.new(model_data[:child_model_1])
    @p = ParentModel.new(model_data[:parent_model_1])
  end

  it "should be possible for ancestor model by specifying ancestor class" do
    @g.should be_descendant_of(ChildModel)
  end

  it "should be possible for ancestor's ancestor model by specifying ancestor's ancestor class" do
    @g.should be_descendant_of(ParentModel)
  end

  it "should fail if model class specified is not an ancestor" do
    @c.should_not be_descendant_of(GrandchildModel)
  end
  
  it "should be possible for ancestor model by specifying ancestor instance" do
    @g.should be_descendant_of(@c)
  end

  it "should be possible for ancestor's ancestor model by specifying ancestor's ancestor instance" do
    @g.should be_descendant_of(@p)
  end

  it "should fail if model class specified is not an ancestor" do
    @c.should_not be_descendant_of(@g)
  end

  it "should be able to determine if model has no ancestor" do
    @p.should be_descendant_of(nil)
  end
  
end

########################################################################################################
describe "validation from model class of inheritance hierarchy" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_1])
    @c = ChildModel.new(model_data[:child_model_1])
    @p = ParentModel.new(model_data[:parent_model_1])
  end

  it "should be possible for ancestor model by specifying ancestor class" do
    GrandchildModel.should be_descendant_of(ChildModel)
  end

  it "should be possible for ancestor's ancestor model by specifying ancestor's ancestor class" do
    GrandchildModel.should be_descendant_of(ParentModel)
  end

  it "should fail if model class specified is not an ancestor" do
    ChildModel.should_not be_descendant_of(GrandchildModel)
  end
  
  it "should be possible for ancestor model by specifying ancestor instance" do
    GrandchildModel.should be_descendant_of(@c)
  end

  it "should be possible for ancestor's ancestor model by specifying ancestor's ancestor instance" do
    GrandchildModel.should be_descendant_of(@p)
  end

  it "should fail if model class specified is not an ancestor" do
    ChildModel.should_not be_descendant_of(@g)
  end

  it "should be able to determine if model has no ancestor" do
    ParentModel.should be_descendant_of(nil)
  end
  
end

########################################################################################################
describe "discovery of model inheritance hierarchy from model instance" do

  it "should return model if model has no ancestors" do
    ParentModel.new(model_data[:parent_model]).class_hierarchy.should eql(['ParentModel'])
  end

  it "should return model and ancestor for model with ancestor" do
    ChildModel.new(model_data[:child_model]).class_hierarchy.should eql(['ChildModel', 'ParentModel'])
  end

  it "should return model, ancestor and ancestor's ancestor for model with ancestor that has ancestor" do
    GrandchildModel.new(model_data[:grandchild_model]).class_hierarchy.should eql(['GrandchildModel', 'ChildModel', 'ParentModel'])
  end

end

########################################################################################################
describe "discovery model inheritance hierarchy from model class of" do

  it "should return model if model has no ancestors" do
    ParentModel.class_hierarchy.should eql(['ParentModel'])
  end

  it "should return model and ancestor for model with ancestor" do
    ChildModel.class_hierarchy.should eql(['ChildModel', 'ParentModel'])
  end

  it "should return model, ancestor and ancestor's ancestor for model with ancestor that has ancestor" do
    GrandchildModel.class_hierarchy.should eql(['GrandchildModel', 'ChildModel', 'ParentModel'])
  end

end

########################################################################################################
describe "discovery from descendant model class of ancestor model class with a specified attribute" do

  it "should return name of model class if attribute belongs to model" do
    ParentModel.ancestor_for_attribute(:parent_model_string).should eql('ParentModel')
  end

  it "should return name of ancestor class if attribute belongs to ancestor" do
    ChildModel.ancestor_for_attribute(:parent_model_string).should eql('ParentModel')
  end

  it "should return name of ancestor's ancestor class if attribute belongs to ancestor's ancestor" do
    GrandchildModel.ancestor_for_attribute(:parent_model_string).should eql('ParentModel')
  end

  it "should return nil if attribute belongs to no class in inheritance hierarchy" do
    GrandchildModel.ancestor_for_attribute(:this_should_fail).should be_nil
  end

end

########################################################################################################
describe "indication of has_descendants declaration" do

  it "should return true when called from model instance when model has descendants" do
    ParentModel.new.should have_descendants
  end

  it "should return true when called from model class when model has descendants" do
    ParentModel.should have_descendants
  end

  it "should return false when called from model instance when model has no descendants" do
    GrandchildModel.new.should_not have_descendants
  end

  it "should return false when called from model class when model has no descendants" do
    GrandchildModel.should_not have_descendants
  end

end
