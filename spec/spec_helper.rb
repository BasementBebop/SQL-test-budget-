require('rspec')
require('pg')
require('pry')
require('purchase')
require('company')

DB = PG.connect({:dbname => "budget_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM purchase *;")
    DB.exec("DELETE FROM company *;")
    DB.exec("DELETE FROM join_table *;")
  end
end
