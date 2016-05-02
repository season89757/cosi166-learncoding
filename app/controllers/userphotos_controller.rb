class UserphotosController < ApplicationController
  before_action :require_login
  def index
    @userphotos = Userphoto.all
  end

  def new
    @userphoto = Userphoto.new

  end

  def create
    Userphoto.where(userid: session[:imdb_user_id]).destroy_all
    if !params[:userphoto].blank?
      @userphoto = Userphoto.new(userphoto_params)
      @userphoto.userid = session[:imdb_user_id]
      if @userphoto.save
        redirect_to users_profile_path
      else
        render "new"
      end
    else
      redirect_to users_profile_path, notice: "Nothing uploaded."
    end
  end

  def destroy
    @userphoto = Userphoto.find(params[:id])
    @userphoto.destroy
    redirect_to userphotos_path, notice:  "Successfully deleted."
  end

  private
    def userphoto_params
      params.require(:userphoto).permit(:userid, :attachment)
    end

    def require_login
      if !session[:imdb_user_id]
        redirect_to imdb_index_path
      end
    end
end
