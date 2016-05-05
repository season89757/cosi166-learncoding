require "pry-byebug"
class SwapController < ApplicationController
  before_action :require_login
  def swaphome
    @user = User.find_by(id: session[:imdb_user_id])
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
    if !find_tradeoff?(@id) && !find_tradein?(@id)
      Tradeoff.create(book_id:@id,user_id:session[:imdb_user_id])
    end
    redirect_to controller: "swap", action: "swaphome", id: params[:id]
  end

  def tradein
    @id = params[:id]
    if !find_tradeoff?(@id) && !find_tradein?(@id)
      Tradein.create(book_id:@id,user_id:session[:imdb_user_id])
    end
    redirect_to controller: "swap", action: "swaphome", id: params[:id]
  end

  def tradeoffnew
    if params[:id] && params[:receiver] && params[:message]
      Message.create(book_id:params[:id],message:params[:message],sender:session[:imdb_user_id],receiver:params[:receiver])
      redirect_to controller: "swap", action: "swaphome", id: params[:id]
    end
  end

  def tradeinnew
    if params[:id] && params[:receiver] && params[:message]
      Message.create(book_id:params[:id],message:params[:message],sender:session[:imdb_user_id],receiver:params[:receiver])
      redirect_to controller: "swap", action: "swaphome", id: params[:id]
    end
  end

  private
    def require_login
      if !session[:imdb_user_id]
        redirect_to imdb_index_path
      end
    end

    def find_tradeoff?(book_id)
      tradeoff = Tradeoff.find_by(user_id:session[:imdb_user_id],book_id:book_id)
      if tradeoff then true else false end
    end
    def find_tradein?(book_id)
      tradein = Tradein.find_by(user_id:session[:imdb_user_id],book_id:book_id)
      if tradein then true else false end
    end
end
