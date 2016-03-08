class ImdbController < ApplicationController
  attr_accessor :book_image, :tag1, :book_name, :id

  def index
    if params[:user_id]
      id = params[:user_id]
      @session = User.find(id)
    end
  end

  def login
    if params[:error] then @error = params[:error] end

    if params[:username]
      @user = User.find_by(username: params[:username], password: params[:password])
      if @user
        session[:user_id]=@user.id
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
          session[:user_id]=@user.id
          redirect_to imdb_index_path
        end
      end
    end
  end

  def result
    @book_image = 'java.jpg'
    @tag1 = 'tag1'
    @tag2 = 'tag2'
    @tag3 = 'tag3'
    @book_name = 'Java 7 Programming'
    @book_rating = 4.5
    @book_description='this is the description of the book,in this book you will learn how to use java and java script to design web. Java language redirects here. For the natural language from the Indonesian island of Java, see Javanese language.
    This article is about a programming language. For the software package downloaded from java.com, see Java SE.
    Not to be confused with JavaScript.'
    @firstpost = 'first post'
    @secondpost = 'secondpost'
  end

  def detail
  end

end
