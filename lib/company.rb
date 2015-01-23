class Company
  attr_reader(:company_name, :category_name, :id)

  define_method(:initialize) do |attributes|
    @company_name = attributes.fetch(:company_name)
    @category_name = attributes.fetch(:category_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_company = DB.exec("SELECT * FROM company;")
    companies = []
    returned_company.each() do |company|
      company_name = company.fetch("company_name")
      category_name = company.fetch("category_name")
      id = company.fetch("id").to_i()
      companies.push(Company.new({:company_name => company_name, :category_name => category_name, :id => id}))
    end
    companies
  end

  define_method(:purchases) do
    list_purchases = []
    purchases = DB.exec("SELECT description.* FROM purchase JOIN join_table ON (company.id = join_table.category_id) JOIN purchase ON (join_table.purchase_id = purchase.id)
    WHERE company.id = 1")
    purchases.each() do |purchase|
      list_purchases.push(purchase)

    end
    list_purchases
  end

  # define_method(:add_purchase) do |purchase|
  #   new_purchase = []
  #     purchase.each() do
  #       new_purchase.push(purchase.description())
  #     end
  #   new_purchase
  # end

  define_method(:save) do
    result = DB.exec("INSERT INTO company (company_name, category_name) VALUES ('#{@company_name}', '#{@category_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:save_to_join) do |purchase|
    @purchase_id = purchase.id()
    @company_id = self.id()
    DB.exec("INSERT INTO join_table (purchase_id, company_id) VALUES ('#{@purchase_id}', '#{@company_id}') RETURNING id;")
  end

  # define_method(:save_join_table) do
  #   @purchase_id = Purchase.new({:description => description, :amount => amount, :date => date, :id => nil}).id()
  #   result = DB.exec("INSERT INTO join_table (company_id, purchase_id) VALUES ('#{@id}', '#{@purchase_id}') RETURNING id;")
  # end

  define_method(:==) do |another_company|
    self.company_name().==(another_company.company_name()).&(self.category_name().==(another_company.category_name())).&(self.id().==(another_company.id()))
  end

end
