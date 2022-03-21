require 'json'
file = File.read("lib/assets/recipes-english.json")
data_hash = JSON.parse(file)

data_hash.each do |r|
  recipe = Recipe.create!(author: r["author"], category: r["category"],
                          cuisine: r["cuisine"],ratings: r["ratings"],
                          prep_time: r["prep_time"], cook_time: r["cook_time"],
                          title: r["title"], image: r["image"],
                          ingredients_desc: [], ingredients_id: [])
  recipe.ingredients_desc = r["ingredients"]

  #create ingredients_id
  ingredients_raw = r["ingredients"]
  ingredients_raw.map! {|i|
    ingredient_name = i.gsub(/(\d|cups|cup|teaspoons|teaspoon|tablespoons|tablespoon|packages|package|ounces|ounce|\.|\(|\))/,"")
    ingredient_name.strip!
    #remove weird fraction char
    if !(ingredient_name =~ /^[a-zA-Z]/)
      ingredient_name = ingredient_name[1..-1]
    end

    ingredient_name.strip!

    db_ingredient = Ingredient.where(name: ingredient_name)
    if db_ingredient.empty?
      puts "Cannot find ingredient: #{ingredient_name}"
    end

    recipe.ingredients_id += [db_ingredient.first.id]
  }
  recipe.save!
  puts "recipe created. id=#{recipe.id}, name=#{recipe.title}"
end