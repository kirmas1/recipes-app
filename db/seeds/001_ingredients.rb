# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'
file = File.read("lib/assets/recipes-english.json")
data_hash = JSON.parse(file)


data_hash.each do |r|
  r["ingredients"].map! {|ingredient_name|
    ingredient_name.gsub!(/(\d|cups|cup|teaspoons|teaspoon|tablespoons|tablespoon|packages|package|ounces|ounce|\.|\(|\))/,"")
    ingredient_name.strip!
    #remove weird fraction char
    if !(ingredient_name =~ /^[a-zA-Z]/)
      ingredient_name = ingredient_name[1..-1]
    end

    ingredient_name.strip!
    puts "normalized ingredient name: #{ingredient_name}"

    i = Ingredient.where(name: ingredient_name)
    if i.empty?
      Ingredient.new(name: ingredient_name).save!
    end
  }
end