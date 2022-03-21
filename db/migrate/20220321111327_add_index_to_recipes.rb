class AddIndexToRecipes < ActiveRecord::Migration
  def change
    add_index :recipes, :ingredients_id, using: :gin
  end
end
