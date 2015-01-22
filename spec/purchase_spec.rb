require('spec_helper')

describe(Purchase) do

  describe(".all") do
    it("shows the array of Purchase objects") do
      expect(Purchase.all()).to(eq([]))
    end
  end

  describe("save") do
    it("lets you save purchases to the database") do
      purchase = Purchase.new({:description => "Burger", :amount => 7.99, :date => "2015-05-23", :id => 1})
      purchase.save()
      expect(Purchase.all()).to(eq([purchase]))
    end
  end



end
