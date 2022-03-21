# t.string  :author
# t.string  :category
# t.float   :cook_time
# t.string  :cuisine
# t.float   :prep_time
# t.float   :ratings
# t.string  :title
# t.string  :ingredients_desc, array: true, default: []
# t.integer :ingredients_id, array: true, default: []
class Recipe < ActiveRecord::Base
  # attr_accessor :author, :category, :cook_time, :cuisine, :prep_time,
  #               :ratings, :title, :ingredients_desc, :ingredients_id
end
