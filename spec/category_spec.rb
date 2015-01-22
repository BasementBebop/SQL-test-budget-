require('spec_helper')

describe(Category) do

  describe(".all") do
    it("shows ALL the categories") do
      expect(Category.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save a category to the database") do
      category = Category.new({:category_name => "Food", :id => 1})
      category.save()
      expect(Category.all()).to(eq([category]))
    end
  end

  describe("#purchases") do
    it("returns an array of purchases for that category") do
      test_category = Category.new({:category_name => "Food", :id => nil})
      test_category.save()
      test_purchase1 = Purchase.new({:description => "Burger", :amount => 7.99, :date => "2015-05-23", :id => nil})
      test_purchase1.save()
      test_purchase2 = Purchase.new({:description => "2 Burgers", :amount => 15.02, :date => "2015-05-24", :id => nil})
      test_purchase2.save()


end
