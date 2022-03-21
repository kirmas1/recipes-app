class RecipesController < ApplicationController
  protect_from_forgery with: :null_session

  def list
    puts "recipes controller params = #{params}"
    ingredients_ids = Ingredient.where(name: params["ingredients"]).map(&:id)
    result = Recipe.where("ingredients_id <@ ARRAY[?]::integer[]", ingredients_ids)
    render :json => result, :status =>  :ok
  end
end
