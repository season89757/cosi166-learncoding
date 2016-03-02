class ImdbController < ApplicationController
  def index
  end

  def login
  end

  def register
  end

  def result
    @book_name = 'Java 7 Programming'
    @book_rating = 4.5
    @book_description='this is the description of the book'
  end

  def detail
  end

end
