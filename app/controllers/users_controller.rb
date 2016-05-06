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
    @likes = Like.where(user_id:session[:imdb_user_id]  )
    @tradeins = Tradein.where(user_id:session[:imdb_user_id])
    @tradeoffs = Tradeoff.where(user_id:session[:imdb_user_id])

    recent_book = Like.find_book(session[:imdb_user_id])
    temp = Tag.find_tags(recent_book.id).first
    if temp
      rec = temp.name
      @results = Book.run_search(rec, tag= rec)
    else
      @results = []
    end

      # query_string = params[:terms]
    # tag = params[:tag]
    # #@results = Book.run_search(query_string, tag= tag)
    # redirect_to search_box_search_results_path
  end

  def delete_tradein
    book_id = params[:book_id]
    tradein = Tradein.find_by(book_id:book_id,user_id:session[:imdb_user_id])
    if tradein
      tradein.destroy
    end
    redirect_to users_profile_path
  end

  def delete_tradeoff
    book_id = params[:book_id]
    tradeoff = Tradeoff.find_by(book_id:book_id,user_id:session[:imdb_user_id])
    if tradeoff
      tradeoff.destroy
    end
    redirect_to users_profile_path
  end

  private
    def require_login
      if !session[:imdb_user_id]
        redirect_to imdb_index_path
      end
    end
end
