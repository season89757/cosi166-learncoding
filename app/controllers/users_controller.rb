require "pry-byebug"

class UsersController < ApplicationController
  before_action :require_login

  # GET /users
  # GET /users.json
  def index
  end

  def profile
    @user = User.find_by(id:session[:imdb_user_id])
    @photo = Userphoto.find_by(userid:session[:imdb_user_id])
    @message = Message.where("receiver = ?",session[:imdb_user_id])
      # query_string = params[:terms]
    # tag = params[:tag]
    # #@results = Book.run_search(query_string, tag= tag)
    # redirect_to search_box_search_results_path
  end

  private
    def require_login
      if !session[:imdb_user_id]
        redirect_to imdb_index_path
      end
    end
end
