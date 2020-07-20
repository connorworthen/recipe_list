class Category < ActiveRecord::Base
has_many :recipes

end
#naming conventions, creating new migrations, tables name, ini. objects

# tux

# category = Category.new

# recipe = Category.new

#@recipe = Recipe.create(name: "cheese", url: "www.cheese.com", category_id: category.id)

# @recipe = Recipe.new(params)

# easier way?

## add/create migration files added for test
