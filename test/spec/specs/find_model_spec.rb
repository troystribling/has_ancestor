require File.dirname(__FILE__) + '/../spec_helper'

#########################################################################################################
describe "database queries for a model where model does not have an ancestor and does not have descendants" do

  before(:all) do
    @p = ParentModel.new(model_data['PARENT_MODEL'])
    @p.save!
  end

  after(:all) do
    @p.destroy
  end

  it "should find model by specification of model primary key" do
    ParentModel.find(@p.id).should have_model_attributes(model_data['PARENT_MODEL'])
  end

  it "should find model by specification of model attribute" do
    ParentModel.find_by_parent_model_attr(model_data['PARENT_MODEL']['parent_model_attr']).should \
      have_model_attributes(model_data['PARENT_MODEL'])
  end

end

#########################################################################################################
describe "database queries for a model where model has descendants and does not have an ancestor" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save!
    @p = ParentModel.find(@c.parent_model_id)
  end

  after(:all) do
    @c.destroy
  end

  it "should find model by specification of model primary key" do
    ParentModel.find(@p.id).should == @p
  end

  it "should find descendant model by specification of descendant model primary key" do
    ChildModel.find(@p.descendant.id).should == @c
  end

  it "should find model by specification of model attribute" do
    ParentModel.find_by_parent_model_attr(model_data['CHILD_MODEL']['parent_model_attr']).should == @p
  end

end

#########################################################################################################
describe "database queries for a model where model has an ancestor and does not have descendants" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save!
  end

  after(:all) do
    @c.destroy
  end
    
  it "should find model by specification of model primary key" do
    ChildModel.find(@c.id).should have_model_attributes(model_data['CHILD_MODEL'])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ParentModel.find(@c.ancestor.id).should have_model_attributes(model_data['CHILD_ANCESTOR_MODEL'])
  end

  it "should find model by specification of model attribute" do
    ChildModel.find_by_child_model_attr(model_data['CHILD_MODEL']['child_model_attr']).should == @c
  end

  it "should find model by specification of ancestor model attribute" do
    ChildModel.find_by_parent_model_attr(model_data['CHILD_MODEL']['parent_model_attr']).to_descendant.should == @c
  end

end


#########################################################################################################
describe "database queries for a model where model has an ancestor and has descendants" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save!
    @c = ChildModel.find(@g.child_model_id)
  end

  after(:all) do
    @g.destroy
  end

  it "should find model by specification of model primary key" do
    ChildModel.find(@c.id).should have_model_attributes(model_data['GRANDCHILD_ANCESTOR_MODEL'])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ParentModel.find(@c.ancestor.id).should \
      have_model_attributes(model_data['GRANDCHILD_ANCESTOR_ANCESTOR_MODEL'])
  end

  it "should find descendant model by specification of descendant model primary key" do
    GrandchildModel.find(@c.descendant.id).should == @g
  end

  it "should find model by specification of model attribute" do
    ChildModel.find_by_child_model_attr(model_data['GRANDCHILD_MODEL']['child_model_attr']).should == @c
  end

  it "should find model by specification of ancestor model attribute" do
    ChildModel.find_by_parent_model_attr(model_data['GRANDCHILD_MODEL']['parent_model_attr']).to_descendant(:child_model).should == @c
  end

end

#########################################################################################################
describe "database queries for a model where model has an ancestor and is a descendant of a model that has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save!
  end

  after(:all) do
    @g.destroy
  end

  it "should find model by specification of model primary key" do
    GrandchildModel.find(@g.id).should have_model_attributes(model_data['GRANDCHILD_MODEL'])
  end

  it "should find ancestor model by specification of ancestor model primary key" do
    ChildModel.find(@g.ancestor.id).should have_model_attributes(model_data['GRANDCHILD_ANCESTOR_MODEL'])
  end

  it "should find ancestor's ancestor model by specification of ancestor's ancestor model primary key" do
    ParentModel.find(@g.ancestor.ancestor.id).should \
      have_model_attributes(model_data['GRANDCHILD_ANCESTOR_ANCESTOR_MODEL'])
  end

  it "should find model by specification of model attribute" do
    GrandchildModel.find_by_grandchild_model_attr(model_data['GRANDCHILD_MODEL']['grandchild_model_attr']).should \
      have_model_attributes(model_data['GRANDCHILD_MODEL'])
  end

  it "should find model by specification of ancestor model attribute" do
    GrandchildModel.find_by_child_model_attr(model_data['GRANDCHILD_MODEL']['child_model_attr']).to_descendant.should \
      have_model_attributes(model_data['GRANDCHILD_MODEL'])
  end

  it "should find model by specification of  ancestor's ancestor model attribute" do
    GrandchildModel.find_by_parent_model_attr(model_data['GRANDCHILD_MODEL']['parent_model_attr']).to_descendant.should \
      have_model_attributes(model_data['GRANDCHILD_MODEL'])
  end

end

#########################################################################################################
describe "database queries for all models of a specified type where the models have no ancestor and no descendants" do

  before(:all) do
    @p1 = ParentModel.new(model_data['PARENT_MODEL'])
    @p1.save!
    @p2 = ParentModel.new(model_data['PARENT_MODEL'])
    @p2.save!
  end

  after(:all) do
    @p1.destroy
    @p2.destroy
  end

  it "should find models by specification of model attribute" do
    ParentModel.find_all_by_parent_model_attr(model_data['PARENT_MODEL']['parent_model_attr']).should \
      have_attribute_value(:parent_model_attr, model_data['PARENT_MODEL']['parent_model_attr']) 
  end

end

#########################################################################################################
describe "database queries for all models of a specified type where the models have no ancestor and have descendants" do

  before(:all) do
    @c1 = ChildModel.new(model_data['CHILD_MODEL'])
    @c1.save!
    @c2 = ChildModel.new(model_data['CHILD_MODEL_FIND_ALL_CHILD'])
    @c2.save!
  end

  after(:all) do
    @c1.destroy
    @c2.destroy
  end

  it "should find models by specification of model attribute" do
    ParentModel.find_all_by_parent_model_attr(model_data['CHILD_MODEL']['parent_model_attr']).should \
      have_attribute_value(:parent_model_attr, model_data['CHILD_MODEL']['parent_model_attr']) 
  end

end

#########################################################################################################
describe "database queries for all models of a specified type where the models have an ancestor and have no descendants" do

  before(:all) do
    @c = ChildModel.new(model_data['CHILD_MODEL'])
    @c.save!
    @cp = ChildModel.new(model_data['CHILD_MODEL_FIND_ALL_PARENT'])
    @cp.save!
    @cc = ChildModel.new(model_data['CHILD_MODEL_FIND_ALL_CHILD'])
    @cc.save!
  end

  after(:all) do
    @c.destroy
    @cp.destroy
    @cc.destroy
  end

  it "should find models by specification of model attribute" do
    ChildModel.find_all_by_child_model_attr(model_data['CHILD_MODEL']['child_model_attr']).should \
      have_attribute_value(:child_model_attr, model_data['CHILD_MODEL']['child_model_attr']) 
  end

  it "should find models by specification of ancestor model attribute" do
    ChildModel.find_all_by_parent_model_attr(model_data['CHILD_MODEL']['parent_model_attr']).should \
      have_attribute_value(:parent_model_attr, model_data['CHILD_MODEL']['parent_model_attr']) 
  end

end

#########################################################################################################
describe "database queries for all models of a specified type where the models have no descendants and have an ancestor has an ancestor" do

  before(:all) do
    @g = GrandchildModel.new(model_data['GRANDCHILD_MODEL'])
    @g.save!
    @gp = GrandchildModel.new(model_data['GRANDCHILD_MODEL_FIND_ALL_PARENT'])
    @gp.save!
    @gc = GrandchildModel.new(model_data['GRANDCHILD_MODEL_FIND_ALL_CHILD'])
    @gc.save!
    @gg = GrandchildModel.new(model_data['GRANDCHILD_MODEL_FIND_ALL_GANDCHILD'])
    @gg.save!
  end

  after(:all) do
    @g.destroy
    @gp.destroy
    @gc.destroy
    @gg.destroy
  end

  it "should find models by specification of model attribute" do
    GrandchildModel.find_all_by_grandchild_model_attr(model_data['GRANDCHILD_MODEL']['grandchild_model_attr']).should \
      have_attribute_value(:grandchild_model_attr, model_data['GRANDCHILD_MODEL']['grandchild_model_attr']) 
  end

  it "should find models by specification of ancestor attribute" do
    GrandchildModel.find_all_by_child_model_attr(model_data['GRANDCHILD_MODEL']['child_model_attr']).should \
      have_attribute_value(:child_model_attr, model_data['GRANDCHILD_MODEL']['child_model_attr']) 
  end

  it "should find models by specification of ancestor's ancestor attribute" do
    GrandchildModel.find_all_by_parent_model_attr(model_data['GRANDCHILD_MODEL']['parent_model_attr']).should \
      have_attribute_value(:parent_model_attr, model_data['GRANDCHILD_MODEL']['parent_model_attr']) 
  end

end
