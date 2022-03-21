class IngredientsController < ApplicationController
  def index
    render :json => Ingredient.all.map(&:name), :status =>  :ok
  end
end