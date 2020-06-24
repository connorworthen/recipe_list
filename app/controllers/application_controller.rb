require './config/env'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if is_logged_in?
      redirect '/recipes'
    else
      erb :'index'
    end
  end

  helpers do

    def current_user
      @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?
      !!current_user
    end

    # def redirect_if_not_logged_in
    #   if !is_logged_in?
    #     # flash[:message] = "Please log in to view that page."
    #     redirect "/"
    #   end
    # end
  end
end