class RecipesController < ApplicationController

  get '/recipes' do
    redirect_if_not_logged_in

    @user = current_user
    @recipes = Recipe.all
    erb :'recipe/index'
  end

  get '/recipes/new' do
    redirect_if_not_logged_in

    @user = current_user
    erb :'recipe/new'
  end

  get '/recipes/:id' do
    redirect_if_not_logged_in

    @recipe = Recipe.find_by_id(params[:id])
    @creator = User.find_by_id(@recipe.user_id)
    @user = current_user
    erb :'recipe/show'
  end

  get '/recipes/:id/edit' do
    redirect_if_not_logged_in
    @recipe = Recipe.find_by_id(params[:id])
    redirect_if_not_creator(@recipe)

    erb :'recipe/edit'
  end

  post '/recipes' do
    @recipe = Recipe.create(params[:recipe])
    bookmark = Bookmark.create(user_id: current_user.id, recipe_id: @recipe.id)

    if !!@recipe.id
      redirect "/recipes/#{@recipe.id}"
    else
      flash[:message] = "Please ensure all recipe information is entered, and that your recipe title is unique"
      redirect '/recipes/new'
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    
    redirect_if_not_creator(@recipe)

    @recipe.update(params[:recipe])
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy

    @bookmarks = Bookmark.all.each do |b|
      if b.recipe_id == params[:id].to_i
        b.destroy
      end
    end

    redirect '/recipes'
  end

  # ROUTES BELOW CONTROLLER USER ADDING AND REMOVING BOOKMARK
  # THIS MAY NOT ADHERE TO RESTFUL ROUTES - HOW WOULD I FIX IT TO BE RESTFUL?

  patch '/recipes/:id/add' do
    @recipe = Recipe.find_by_id(params[:id])
    current_user.add_bookmark(@recipe)
    redirect "/users/#{current_user.id}/bookmarks"
  end

  patch '/recipes/:id/remove' do
    @recipe = Recipe.find_by_id(params[:id])
    current_user.remove_bookmark(@recipe)
    redirect "/users/#{current_user.id}/bookmarks"
  end

end
