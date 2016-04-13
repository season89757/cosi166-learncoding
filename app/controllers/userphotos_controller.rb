class UserphotosController < ApplicationController
  def index
    @userphotos = Userphoto.all
  end

  def new
    @userphoto = Userphoto.new
  end

  def create
    @userphoto = Userphoto.new(userphoto_params)

      if @userphoto.save
         redirect_to users_profile_path, notice: "Successfully uploaded."
      else
         render "new"
      end
  end

  def destroy
    @userphoto = Userphoto.find(params[:id])
    @userphoto.destroy
    redirect_to userphotos_path, notice:  "Successfully deleted."
  end

  private
      def userphoto_params
      params.require(:userphoto).permit(:username, :attachment)
   end
end
