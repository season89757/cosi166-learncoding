class ImdbController < ApplicationController
  attr_accessor :book_image, :tag1, :book_name, :id

  def index
    # image = open('/home/boyang/Dropbox/cosi166b_ban/cosi166-learncoding/app/assets/images/imdb_logo25.png') { |f| f.read }
    # test1 = Base64.encode64(image)
    # logo_url = Base64.decode64(test1)
    # @logo_src = "data:image/png;base64," + logo_url

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
