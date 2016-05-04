class LoveController < ApplicationController
  before_action :require_login
  def like
    if params[:id]
      Like.create(user_id: session[:imdb_user_id], book_id: params[:id])
    end

    # binding.pry
  end

  private
  def require_login
    if !session[:imdb_user_id]
      redirect_to imdb_index_path
    end
  end
end
