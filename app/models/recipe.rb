class Recipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :category #category model
  has_many :ingredients
  has_many :bookmarks

  validates_presence_of :name, :url
  validates :name, uniqueness: true

end


#conventions, get a model and migration foreign key, active record, class names singular etc. snake case migration belongs/has_many connects db key,

 # ingredient = Ingredient.create(name: "eggs", recipe_id: recipe.id) 
 # created new migration file ingredients then made model class and added has_many to recipe in order to add the name of an ingredient
 # to "fried rice" do ingredient = Recipe.new then recipe.ingredients.build(name: "rice") or 
 # ingredient = Ingredient.create(name: "eggs", recipe_id: recipe.id)
 # study line 13 and write down to bettr understand 