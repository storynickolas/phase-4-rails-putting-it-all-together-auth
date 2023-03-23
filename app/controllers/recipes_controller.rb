class RecipesController < ApplicationController

  def index
    user = User.find_by(id: session[:user_id])
    if user
      render json: Recipe.all, status: :created
    else
      render json: { errors: "Not Authorized" }, status: :unauthorized
    end
  end

  def create
    user = User.find_by(id: session[:user_id])
    recipe = Recipe.create(recipe_params)
    if recipe.valid? && user
      render json: recipe, status: :created
    elsif user
      render json: [ user.errors ] , status: :unprocessable_entity
    else
      render json: { errors: "Not Authorized" }, status: :unauthorized
    end
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

end
