require "pry-byebug"
class SwapController < ApplicationController
  before_action :require_login
  def swaphome
    @tradeoff_users = []
    @tradein_users = []
    @id = params[:id]

    tradeoff_users = Tradeoff.find_users(@id)
    tradeoff_users.each do |t|
      @tradeoff_users << User.find_by(id:t.user_id)
    end

    tradein_users = Tradein.find_users(@id)
    tradein_users.each do |t|
      @tradein_users << User.find_by(id:t.user_id)
    end
  end

  def tradeoff
    @id = params[:id]
    user = Tradeoff.find_by(book_id:@id,user_id:session[:imdb_user_id])
    if !user
      Tradeoff.create(book_id:@id,user_id:session[:imdb_user_id])
      redirect_to controller: "swap", action: "swaphome", id: params[:id]
    else
      redirect_to controller: "swap", action: "swaphome", id: params[:id]
    end
  end

  def tradein
    @id = params[:id]
    user = Tradein.find_by(book_id:@id,user_id:session[:imdb_user_id])
    if !user
      Tradein.create(book_id:@id,user_id:session[:imdb_user_id])
      redirect_to controller: "swap", action: "swaphome", id: params[:id]
    else
      redirect_to controller: "swap", action: "swaphome", id: params[:id]
    end
  end

  def tradeoffnew
    if params[:id] && params[:receiver] && params[:message]
      Message.create(book_id:params[:id],message:params[:message],sender:session[:imdb_user_id],receiver:params[:receiver])
      redirect_to controller: "swap", action: "swaphome", id: params[:id]
    end
  end

  def tradeinnew

  end


  private
  def require_login
    if !session[:imdb_user_id]
      redirect_to imdb_index_path
    end
  end
end
