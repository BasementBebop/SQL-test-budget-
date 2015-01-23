class Purchase
  attr_reader(:description, :amount, :date, :id)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @amount = attributes.fetch(:amount)
    @date = attributes.fetch(:date)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_purchases = DB.exec("SELECT * FROM purchase;")
    purchases = []
    returned_purchases.each() do |purchase|
      description = purchase.fetch("description")
      amount = purchase.fetch("amount").to_f()
      date = purchase.fetch("date")
      id = purchase.fetch("id").to_i()
      purchases.push(Purchase.new({:description => description, :amount => amount, :date => date, :id => id}))
    end
    purchases
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO purchase (description, amount, date) VALUES ('#{@description}', #{@amount}, '#{@date}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_purchase|
    self.description().==(another_purchase.description()).&(self.amount().==(another_purchase.amount())).&(self.date().==(another_purchase.date())).&(self.id().==(another_purchase.id()))
  end


end
