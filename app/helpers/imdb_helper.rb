module ImdbHelper
  def index_top
    if session[:imdb_user_id]
      @user = User.find_by(id: session[:imdb_user_id])
      if @user.admin == '1'
        "Hello Adminstrator " + @user.display_name
      else
        "Hello " + @user.display_name
      end
    end
  end

  def login_error
    if @error then @error end
  end
end
