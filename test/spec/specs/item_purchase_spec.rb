require File.dirname(__FILE__) + '/../spec_helper'

################################################################################################
describe "item_purchase inherited attributes", :shared=> true do

  it "should have attribute indicating purchase is closed" do
    @item.should respond_to(:closed)
  end

  it "should have attribute describing item" do
    @item.should respond_to(:item)
  end

  it "should have attribute specifying item unit cost" do
    @item.should respond_to(:unit_cost)
  end

  it "should have attribute specifying item unit count" do
    @item.should respond_to(:unit_count)
  end

  it "should have attribute specifying item cost" do
    @item.should respond_to(:cost)
  end

end

################################################################################################
describe "item_purchase attributes" do

  before(:all) do
    @item = ItemPurchase.new()
  end

  it "should have attribute indicating purchase is closed" do
    @item.should respond_to(:closed)
  end

  it "should have attribute describing item" do
    @item.should respond_to(:item)
  end

  it "should have attribute specifying item unit cost" do
    @item.should respond_to(:unit_cost)
  end

  it "should have attribute specifying item unit count" do
    @item.should respond_to(:unit_count)
  end

  it "should have attribute specifying item cost" do
    @item.should respond_to(:cost)
  end

end

################################################################################################
describe "item_purchase model relations" do

  it "it should have stock_item_purchase as a descendant" do
    StockItemPurchase.new().should be_descendant_of(:item_purchase)
  end

  it "it should have contract_item_purchase as a descendant" do
    ContractItemPurchase.new().should be_descendant_of(:item_purchase)
  end

end

################################################################################################
describe "contract_item_purchase attributes" do

  before(:all) do
    @contract_item = ContractItemPurchase.new() 
    @item = @contract_item.ancestor
  end

  it_should_behave_like "item_purchase inherited attributes"

  it "should have attribute specifying contract length" do
    @contract_item.should respond_to(:length)
  end

end

################################################################################################
describe "stock_item_purchase attributes" do

  before(:all) do
    @stock_item = StockItemPurchase.new()
    @item = @stock_item.ancestor
  end

  it_should_behave_like "item_purchase inherited attributes"

  it "should have attribute specifying if item is in inventory" do
    @stock_item.should respond_to(:in_inventory)
  end
  
end

################################################################################################
describe "closing item purchases" do

  it "should compute total cost as product of unit count and unit cost and close purchase for item_purchase" do
    item = ItemPurchase.new(model_data['ITEM_PURCHASE'])
    item.close_item_purchase
    item.cost.should eql(model_data['ITEM_PURCHASE']['unit_cost'] * model_data['ITEM_PURCHASE']['unit_count'])
    item.closed.should eql(1)
  end

  it "should compute total cost as product of unit count and unit cost and close purchase for stock_item_purchase" do
    item = StockItemPurchase.new(model_data['STOCK_ITEM_PURCHASE'])
    item.close_item_purchase
    item.cost.should eql(model_data['STOCK_ITEM_PURCHASE']['unit_cost'] * model_data['STOCK_ITEM_PURCHASE']['unit_count'])
    item.closed.should eql(1)
  end

  it "should compute total cost as product of contract length, unit count and unit cost and close purchase for contract_item_purchase" do
    item = ContractItemPurchase.new(model_data['CONTRACT_ITEM_PURCHASE'])
    item.close_item_purchase
    item.cost.should eql(model_data['CONTRACT_ITEM_PURCHASE']['unit_cost'] * model_data['CONTRACT_ITEM_PURCHASE']['unit_count'] \
      * model_data['CONTRACT_ITEM_PURCHASE']['length'])
    item.closed.should eql(1)
  end

end

################################################################################################
describe "closing item purchases from an ancestor model" do

  it "should close stock_item_purchase when called from item_purchase ancestor" do
    item = StockItemPurchase.new(model_data['STOCK_ITEM_PURCHASE'])
    item.save!
    item = ItemPurchase.find_by_item(model_data['STOCK_ITEM_PURCHASE']['item'])
    item.close_item_purchase
    item.save!
    ItemPurchase.find_by_item(model_data['STOCK_ITEM_PURCHASE']['item']).cost.should
      eql(model_data['STOCK_ITEM_PURCHASE']['unit_cost'] * model_data['STOCK_ITEM_PURCHASE']['unit_count'])
    ItemPurchase.find_by_item(model_data['STOCK_ITEM_PURCHASE']['item']).closed.should eql(1)
    item.destroy
  end

  it "should close contract_item_purchase when called from item_purchase ancestor" do
    item = ContractItemPurchase.new(model_data['CONTRACT_ITEM_PURCHASE'])
    item.save!
    item = ItemPurchase.find_by_item(model_data['CONTRACT_ITEM_PURCHASE']['item'])
    item.close_item_purchase
    item.save!
    ItemPurchase.find_by_item(model_data['CONTRACT_ITEM_PURCHASE']['item']).cost.should 
      eql(model_data['CONTRACT_ITEM_PURCHASE']['unit_cost'] * model_data['CONTRACT_ITEM_PURCHASE']['unit_count'] \
       * model_data['CONTRACT_ITEM_PURCHASE']['length'])
    ItemPurchase.find_by_item(model_data['CONTRACT_ITEM_PURCHASE']['item']).closed.should eql(1)
    item.destroy
  end

end

################################################################################################
describe "closing all open purchased items" do

  it "should be possible to close descendants of item purchase from the descendant item_purchase instance" do
    @contract_item = ContractItemPurchase.new(model_data['CONTRACT_ITEM_PURCHASE'])
    @contract_item .save!
    @stock_item = StockItemPurchase.new(model_data['STOCK_ITEM_PURCHASE'])
    @stock_item.save!
    ItemPurchase.find_all_by_closed(0).each do |item|
      item.close_item_purchase
      item.save!
    end
    ItemPurchase.find(:all).each do |item|
      item.closed.should eql(1)
    end
    @contract_item.destroy
    @stock_item.destroy
  end

end
