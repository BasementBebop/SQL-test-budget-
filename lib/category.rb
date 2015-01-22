class Category
  attr_reader(:category_name, :id)

  define_method(:initialize) do |attributes|
    @category_name = attributes.fetch(:category_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_categories = DB.exec("SELECT * FROM category;")
    categories = []
    returned_categories.each() do |category|
      category_name = category.fetch("category_name")
      id = category.fetch("id").to_i()
      categories.push(Category.new({:category_name => category_name, :id => id}))
    end
    categories
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO category (category_name) VALUES ('#{@category_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_category|
    self.category_name().==(another_category.category_name()).&(self.id().==(another_category.id()))
  end

end
