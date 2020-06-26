class ChangeRecipesColumnName < ActiveRecord::Migration
  def change
    rename_column(:recipes, :creator_id, :user_id)
  end
end
