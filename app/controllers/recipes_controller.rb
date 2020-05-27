class RecipesController < ApplicationController

  get "/recipes" do
    # if signed_in?
      @user = User.find(session[:user_id])
      erb :"recipe/index.html"
  end

  get "/recipes/new" do
    if signed_in?
      @user = User.find_by(id: session[:user_id])
      erb :"/recipe/new.html"
    else
      redirect "/signin"
    end
  end

  post "/recipes" do
    if signed_in?
      @user = User.find(session[:user_id])
      if params[:chore].empty?
        redirect "/recipes/new"
      else
        @user = User.find_by(:id => session[:user_id])
        @recipe = Recipe.new
        @recipe.chore = params[:chore]
        @recipe.user_id = @user.id
        @recipe.save
        redirect "/recipes"
      end
    else
      redirect "/signin"
    end
  end

#   get '/recipes/:id' do
#     if signed_in?
#       @recipe = Recipe.find(params[:id])
#       if @recipe && @recipe.user == current_user
#       erb :'/recipe/show.html'
#     else
#       redirect "/signin"
#     end
#   end

#   get "/recipes/:id/edit" do
#     @user = User.find_by(id: session[:user_id])
#     @recipe = recipe.find(params[:id])
#     if @recipe && @recipe.user == current_user
#     erb :"/recipes/edit.html"
#     else
#       redirect "/recipes"
#     end
#   end

#   patch '/recipes/:id' do
#     if signed_in?
#       if params[:chore].empty?
#         redirect "/recipes/#{params[:id]}/edit"
#       else
#         @recipe = Recipe.find_by_id(params[:id])
#         if @recipe && @recipe.user == current_user
#           if @recipe.update(:chore => params[:chore])
#             redirect to "/recipes/#{@recipe.id}"
#           else
#           redirect to "/recipes/#{@recipe.id}/edit"
#           end
#         else
#           redirect to '/recipes'
#         end
#       end
#     else
#       redirect '/recipes'
#     end
#   end

#   delete '/recipes/:id/delete' do
#    if signed_in?
#      @user = User.find_by(id: session[:user_id]) if session[:user_id]
#      @recipe = recipe.find_by_id(params[:id])
#      if @recipe && @recipe.user == current_user
#        @recipe.delete
#        redirect '/recipes'
#      end
#    else
#      redirect to '/signin'
#    end
#  end
end
