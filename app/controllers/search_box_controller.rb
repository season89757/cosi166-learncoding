class SearchBoxController < ApplicationController

  def search_results
    query_string = params[:terms]
    @results = Book.run_search(query_string)

  end

  def book_detail
    id = params[:book_id]
    @book = Book.find_by(id: id)
    @comments = @book.comments
  end

  def create
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
end
