class RecipesController < ApplicationController

  get "/recipes" do
    @user = User.find_by(id: session[:user_id])
    @recipes = Recipe.all
    erb :'/recipe/index.html'
  end

  get "/recipes/new" do
    @user = User.find_by(id: session[:user_id])
    @user = current_user
    erb :"/recipe/new.html"
  end

  post "/recipes" do
    @user = User.find_by(:id => session[:user_id])
    @recipe = Recipe.new
    @recipe.list = params[:list]
    # @recipe.user_id = @user.id
    @recipe.save
    redirect '/homepage'
  end

  get '/recipes/:id' do
    @user = User.find_by(id: session[:user_id])
    # @recipe = Recipe.(params[:id])
    @recipes = Recipe.all
    erb :'/recipe/index.html' 
  end

  get '/recipes/:id/edit' do
    @user = User.find_by(id: session[:user_id])
    @recipe = Recipe.find_by_id(params[:recipe])
    # @recipes = recipe.all

    erb :'recipe/edit.html'
  end

  patch '/recipes/:id' do
    u = current_user
    @recipe = Recipe.find_by(id: params[:id])
    authorize_user(@recipe)
    @recipe.update(recipes_name: params[:recipes_name], ingredients: params[:ingredients], instructions: params[:instructions])
    redirect "/recipes/#{u.id}"
  end

  delete '/recipes/:id/delete' do
    @user = User.find_by(id: session[:user_id]) if session[:user_id]
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete  
    redirect "/homepage"
  end
end
