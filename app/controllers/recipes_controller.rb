class RecipesController < ApplicationController

  get "/recipes" do
    @user = User.find_by(id: session[:user_id])
    erb :'/recipe/index.html'
  end

  get "/recipes/new" do
    @user = User.find_by(id: session[:user_id])
    erb :"/recipe/new.html"
  end

  post "/recipes" do
    @user = User.find(session[:user_id])
    @recipe = Recipe.new
    @recipe.recipes_name = params[:recipes_name]
    @recipe.ingredients = params[:ingredients]
    @recipe.instructions = params[:instructions]
    @recipe.user_id = @user.id
    @recipe.save
    redirect '/homepage'
  end

  get '/recipes/:id' do
   @user = User.find_by(id: session[:user_id])
   @recipe = Recipe.find(params[:id])
   @recipe && @recipe.user == current_user
   erb :'/recipe/show.html'
  end

  get '/recipes/:id/edit' do
    @user = User.find_by(id: session[:user_id])
    @recipe = Recipe.find(params[:id])
    @recipe && @recipe.user == current_user
    erb :'recipe/edit.html'
  end

  patch '/recipe/:id' do
    u = current_user
    @recipe = Recipe.find_by(id: params[:id])
    authorize_user(@recipe)
    @recipe.update(recipes_name: params[:recipes_name], ingredients: params[:ingredients], instructions: params[:instructions])
    redirect "/recipes/#{u.id}"
  end

  delete '/recipes/:id/delete' do
    recipe = Recipe.find_by(id: params[:id])
    authorize_user(recipe)
    u = current_user
    if recipe
      recipe.destroy   
      redirect "/recipes/#{u.id}"
    end
  end
end