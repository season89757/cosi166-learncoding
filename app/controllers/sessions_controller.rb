class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_name(params[:username])
    if user && user.authenticate(params[:password])
      session[:username] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:username] = nil
    redirect_to store_url, notice: "Logged out"
  end

  def create_test(username, password)
    user = User.find_by(username: username)
    if user
    #  redirect_to admin_url
      return true
    else
      #redirect_to imdb_login_path, alert: "Invalid user/password combination"
      return false
    end
  end


end
