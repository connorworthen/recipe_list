class RecipesController < ApplicationController

  # use Rack::Flash

  get '/recipes' do
    is_logged_in?

    @user = current_user
    @recipes = Recipe.all
    erb :'recipe/index.html'
  end

  get '/recipes/new' do
    redirect_if_not_logged_in

    @user = current_user
    erb :'recipe/new.html'
  end

  get '/recipes/:id' do
    redirect_if_not_logged_in

    @recipe = Recipe.find_by_id(params[:id])
    @creator = User.find_by_id(@recipe.user_id)
    @user = current_user
    erb :'recipe/show.html'
  end

  get '/recipes/:id/edit' do
    redirect_if_not_logged_in
    @recipe = Recipe.find_by_id(params[:id])
    # redirect_if_not_creator(@recipe)

    erb :'recipe/edit.html'
  end

  post '/recipes' do
    @recipe = Recipe.create(params[:recipe])
    # bookmark = Bookmark.create(user_id: current_user.id, recipe_id: @recipe.id)

    if !!@recipe.id
      redirect "/recipes/#{@recipe.id}"
    # else
    #   flash[:message] = "Please ensure all recipe information is entered, and that your recipe title is unique"
    #   redirect '/recipes/new'
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    
    # redirect_if_not_creator(@recipe)

    @recipe.update(params[:recipe])
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  # delete '/recipes/:id/delete' do
  #   @recipe = Recipe.find_by_id(params[:id])
  #   @recipe.destroy

  #   @bookmarks = Bookmark.all.each do |b|
  #     if b.recipe_id == params[:id].to_i
  #       b.destroy
  #     end
  #   end

  #   redirect '/recipes'
  # end
end