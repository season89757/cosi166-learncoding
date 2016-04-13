class ImdbController < ApplicationController
  attr_accessor :book_image, :tag1, :book_name, :id

  def index
    logo = Image.find_by(name: 'logo2')
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

    if params[:_user_id]
      id = params[:user_id]
      @session = User.find(id)
    end
  end

  def login
    if params[:error] then @error = params[:error] end

    if params[:username]
      @user = User.find_by(username: params[:username], password: params[:password])
      if @user
        session[:imdb_user_id]=@user.id
        redirect_to imdb_index_path
      else
        redirect_to imdb_login_path(:error => "Wrong credentials")
      end
    end
  end

  def register
    if params[:error] then @error = params[:error] end

    if params[:username]
      if params[:password] != params[:confirm]
        redirect_to imdb_register_path(:error => "Passwords do not match")
      else
        user_exists = User.find_by(username:params[:username])
        email_exists = User.find_by(email:params[:email])
        if user_exists || email_exists
          redirect_to imdb_register_path(:error => "User or Email already exists")
        else
          @user = User.create(username: params[:username], password: params[:password], email: params[:email], display_name: params[:display_name])
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

end
