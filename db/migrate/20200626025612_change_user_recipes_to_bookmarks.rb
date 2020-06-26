class ChangeUserRecipesToBookmarks < ActiveRecord::Migration
  def change
    rename_table('user_recipes', 'bookmarks')
  end
end

