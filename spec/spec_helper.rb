require('rspec')
require('pg')
require('pry')
require('purchase')
require('category')
require('company')

DB = PG.connect({:dbname => "budget_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM purchases *;")
    DB.exec("DELETE FROM company *;")
    DB.exec("DELETE FROM category *;")
    DB.exec("DELETE FROM purchase_company *;")
  end
end
