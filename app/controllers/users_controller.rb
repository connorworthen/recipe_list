class UsersController < ApplicationController

  get "/login" do
    erb :"/users/login.html"
  end

  post '/login' do
    @user = User.find_by(:name => params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/homepage'
    end
  end
  #   redirect '/users/login'
  # end
  
  get "/signup" do
    erb :'/users/new.html'
  end

  post "/signup" do
    puts params
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    redirect "/homepage"
  end

  get '/signout' do
    session.clear
    redirect '/'
  end

  get '/homepage' do
    @user = User.find(session[:user_id])
    erb :'/recipe/index.html'
  end
end