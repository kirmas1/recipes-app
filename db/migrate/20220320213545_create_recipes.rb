class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string  :author
      t.string  :category
      t.float   :cook_time
      t.string  :cuisine
      t.float   :prep_time
      t.float   :ratings
      t.string  :title
      t.string  :ingredients_desc, array: true, default: []
      t.integer :ingredients_id, array: true, default: []
    end
  end
end
