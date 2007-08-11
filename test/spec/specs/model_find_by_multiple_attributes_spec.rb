require File.dirname(__FILE__) + '/../spec_helper'

################################ #################################################################
#describe "database queries by multible attributes for a model where model does not have an ancestor and does not have descendants" do
#
#  before(:all) do
#    @p = ParentModel.new(model_data[:parent_model_multiple_find])
#    @p.save
#  end
#
#  after(:all) do
#    @p.destroy
#  end
#
#  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
#    ParentModel.find(:first, :conditions => "parent_model_attr = '#{model_data[:parent_model_multiple_find]['parent_model_attr']}' and parent_model_other_attr = '#{model_data[:parent_model_multiple_find]['parent_model_other_attr']}'").attributes.should \
#      eql_attributes(model_data[:parent_model_multiple_find])
#  end
#
#  it "should find model with generated finder which uses mutiple model attribute match condition where all attributes belong to model" do
#    ParentModel.find_by_parent_model_attr_and_parent_model_other_attr(model_data[:parent_model_multiple_find]['parent_model_attr'], model_data[:parent_model_multiple_find]['parent_model_other_attr']).attributes.should \
#      eql_attributes(model_data[:parent_model_multiple_find])
#  end
#
#end
#
#################################################################################################
describe "database queries by multible attributes for a model where model has an ancestor and does not have descendants" do

  before(:all) do
    @c = ChildModel.new(model_data[:child_model_multiple_find])
    @c.save
  end

  after(:all) do
    @c.destroy
  end

#  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
#    ChildModel.find(:first, :conditions => "child_model_attr = '#{model_data[:child_model_multiple_find]['child_model_attr']}' and child_model_other_attr = '#{model_data[:child_model_multiple_find]['child_model_other_attr']}'").attributes.should \
#      eql_attributes(model_data[:child_model_multiple_find])
#  end
#
#  it "should find model by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestor" do
#    ChildModel.find(:first, 
#      :conditions => "child_models.child_model_attr = '#{model_data[:child_model_multiple_find]['child_model_attr']}' AND parent_models.parent_model_attr = '#{model_data[:child_model_multiple_find]['parent_model_attr']}'",
#      :joins => "LEFT JOIN parent_models ON parent_models.parent_model_descendant_id = child_models.child_model_id").attributes.should \
#      eql_attributes(model_data[:child_model_multiple_find])
#  end

end

#################################################################################################
describe "database queries by multible attributes for a model where model has an ancestor and ancestor has ancestor but does not have descendants" do

  before(:all) do
    @g = GrandchildModel.new(model_data[:grandchild_model_multiple_find])
    @g.save
  end

  after(:all) do
    @g.destroy
  end

#  it "should find model by specification of mutiple model attribute match condition where all attributes belong to model" do
#    ChildModel.find(:first, :conditions => "child_model_attr = '#{model_data[:child_model_multiple_find]['child_model_attr']}' and child_model_other_attr = '#{model_data[:child_model_multiple_find]['child_model_other_attr']}'").attributes.should \
#      eql_attributes(model_data[:child_model_multiple_find])
#  end
#
  it "should find model by specification of mutiple model attribute match condition where some attributes belong to model and other belong to ancestorof ancestor" do
    gchk = GrandchildModel.find(:first, 
      :conditions => "grandchild_models.grandchild_model_attr = '#{model_data[:grandchild_model_multiple_find]['grandchild_model_attr']}' AND parent_models.parent_model_attr = '#{model_data[:grandchild_model_multiple_find]['parent_model_attr']}'",
      :joins => ["LEFT JOIN child_models ON child_models.child_model_descendant_id = grandchild_models.grandchild_model_id LEFT JOIN parent_models ON parent_models.parent_model_descendant_id = child_models.child_model_id"])
      gchk.attributes.should eql_attributes(model_data[:grandchild_model_multiple_find])
      p gchk.class.name
      p gchk.ancestor.class.name
      p gchk.ancestor.ancestor.class.name
  end

end
