require "pry-byebug"

class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index

  end

  def profile
    
    @user = User.find_by(id:session[:imdb_user_id])
  end

end
