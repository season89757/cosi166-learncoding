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
    @book_description='this is the description of the book,in this book you will learn how to use java and java script to design web. Java language redirects here. For the natural language from the Indonesian island of Java, see Javanese language.
    This article is about a programming language. For the software package downloaded from java.com, see Java SE.
    Not to be confused with JavaScript.'
  end

  def detail
  end

end
