require('spec_helper')

describe(Company) do

  describe(".all") do
    it("shows ALL the categories") do
      expect(Company.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save a category to the database") do
      company = Company.new({:company_name => "Joes Burgers", :category_name => "Food", :id => nil})
      company.save()
      expect(Company.all()).to(eq([company]))
    end
  end

  describe("#purchases") do
    it("associates a purchase with the company") do
      test_company = Company.new({:company_name => "Joes Burgers", :category_name => "Food", :id => nil})
      test_company.save()
      test_purchase1 = Purchase.new({:description => "Burger", :amount => 7.99, :date => "2015-05-23", :id => nil})
      test_purchase1.save()
      test_company.save_to_join(test_purchase1)
      expect(test_company.purchases()).to(eq([test_purchase1]))
    end
  end



  # describe("#purchases") do
  #   it("returns an array of purchases for that category") do
  #     test_company = Company.new({:company_name => "Joes Burgers", :category_name => "Food", :id => nil})
  #     test_company.save()
  #     test_purchase1 = Purchase.new({:description => "Burger", :amount => 7.99, :date => "2015-05-23", :id => nil})
  #     test_purchase1.save()
  #     test_purchase2 = Purchase.new({:description => "2 Burgers", :amount => 15.02, :date => "2015-05-24", :id => nil})
  #     test_purchase2.save()
  #     test_company.add_purchase(test_purchase1)
  #     test_company.add_purchase(test_purchase2)
  #     expect(test_company.purchases()).to(eq(["Burger", "2 Burgers"]))
  #   end
  # end


end
