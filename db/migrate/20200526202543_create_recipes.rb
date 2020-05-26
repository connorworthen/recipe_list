class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :recipes_name
      t.string :ingredients
      t.string :instructions
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
