require 'pry-byebug'
class SearchBoxController < ApplicationController

  def search_results
    query_string = params[:terms]
    tag = params[:tag]
    @results = Book.run_search(query_string, tag= tag)
  end

  def book_detail
    @user = User.find_by(id: session[:imdb_user_id])
    id = params[:book_id]
    @book = Book.find_by(id: id)
    @comments = @book.comments
    @photo = Userphoto.find_by(userid: session[:imdb_user_id])
  end

  def comment
    @user = User.find_by(id: session[:imdb_user_id])
    title = params[:comment_title]
    body = params[:comment_body]
    book_id = params[:book_id]
    user_id = session[:imdb_user_id]
    comment = Comment.new(user_id:user_id, book_id:book_id, title:title, body:body)
    if comment
      comment.save
    end
    book = Book.find_by(id:book_id)
    @comments = book.comments

    respond_to do |format|
      format.js
    end
    
  end

  def sectioncomment
    id = params[:id]
    @book = Book.find_by(id: id)
    @comments = @book.comments
    @photo = Userphoto.find_by(userid: session[:imdb_user_id])
    @section_target = "section_comment"
    #binding.pry
    respond_to do |format|
      format.js
    end
  end

  def sectiondetail
    id = params[:id]
    @book = Book.find_by(id: id)
    @section_target = "section_detail"
    #binding.pry
    respond_to do |format|
      format.js
    end
  end

  private
  def call_pusher(book_id)
    book = Book.find_by(id:book_id)
    coms = book.comments
    Pusher.trigger('IMDBchannel', 'my_event', {
      comments: coms
    })
  end
end
