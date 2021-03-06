class ImdbController < ApplicationController
  attr_accessor :book_image, :tag1, :book_name, :id

  def index
    logo = Image.find_by(name: 'logo_5')
    logo_base64 = logo.base64
    @logo_src = "data:image/png;base64," + logo_base64

    white_arrow = Image.find_by(name: 'white_arrow')
    white_arrow_base64 = white_arrow.base64
    @white_arrow_src = "data:image/png;base64," + white_arrow_base64

    black_arrow = Image.find_by(name: 'black_arrow')
    black_arrow_base64 = black_arrow.base64
    @black_arrow_src = "data:image/png;base64," + black_arrow_base64

    background = Image.find_by(name: 'background')
    background_base64 = background.base64
    @background_src = "data:image/png;base64," + background_base64

    all_tags = Tag.uniq.pluck(:name)
    @dropdown_choices = [['Any Topic', 'Any Topic']]
    all_tags.each do |tag|
      @dropdown_choices.push( [tag, tag] )
    end
    @dropdown_choices.sort_by!{ |each| each[0].downcase }


    if params[:_user_id]
      id = params[:user_id]
      @session = User.find(id)
    end

    if session[:imdb_user_id]
      @user = User.find_by(id:session[:imdb_user_id])
      @photo = Userphoto.find_by(userid:session[:imdb_user_id])
    end
  end

  def login
    if !session[:imdb_user_id]
      @user = User.find_by(username: params[:username], password: params[:password])
      if @user
        session[:imdb_user_id]=@user.id
        redirect_to imdb_index_path
      else
        redirect_to imdb_index_path, notice: "Username does not match the password, please login again!"
      end
    end
  end

  def register
    if params[:imdb_user_name]=="" || params[:confirm]=="" || params[:password]=="" || params[:display_name]=="" || params[:email]==""
      redirect_to imdb_index_path, notice: "Input is empty"
    else
      if params[:password] != params[:confirm]
        redirect_to imdb_index_path, notice: "Passwords do not match"
      else
        user_exists = User.find_by(username:params[:imdb_user_name])
        email_exists = User.find_by(email:params[:email])
        if user_exists || email_exists
          redirect_to imdb_index_path, notice: "User or Email already exists"
        else
          @user = User.create(username: params[:imdb_user_name], password: params[:password], email: params[:email], display_name: params[:display_name])
          session[:imdb_user_id]=@user.id
          redirect_to imdb_index_path
        end
      end

    end
  end

  def logout
    if session[:imdb_user_id]
      session[:imdb_user_id] = nil
    end
    redirect_to imdb_index_path
  end

  def new_release
    respond_to do |format|
      format.html
      format.js
    end
  end

end
