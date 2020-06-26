class UsersController < ApplicationController

  get '/login' do
    if is_logged_in?
      @user = current_user
      redirect "/recipes"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if !!@user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/recipes"
    else
      flash[:message] = "Incorrect usernae or password, please try again or sign up"
      redirect '/login'
    end
  end

  get '/signup' do
    if is_logged_in?
      @user = current_user 
      redirect "/recipes"
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.create(params[:user])

    if !!@user.id
      session[:name] = @user.username
      session[:user_id] = @user.id
      redirect "/recipes"
    else
      flash[:message] = "An error has occured, please try again or signin"
      redirect to '/signup'
    end
  end

  get '/users/:id/bookmarks' do
    redirect_if_not_logged_in

    @user = User.find_by_id(params[:id])
    erb :'users/index'
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end
