class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :recipes


  has_secure_password
  validates_presence_of :username, :password_digest
  validates :username, uniqueness: true

  def bookmarked_recipes
    self.bookmarks.collect {|b| b.recipe}
  end

  def add_bookmark(recipe)
    Bookmark.create(user_id: self.id, recipe_id: recipe.id)
    save
  end

  def remove_bookmark(recipe)
    bookmark = Bookmark.find_by(user_id: self.id, recipe_id: recipe.id)
    bookmark.destroy
    save
  end


end
