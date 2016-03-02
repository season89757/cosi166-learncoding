require 'minitest/autorun'
require_relative '../../app/controller/imdb_controller'
#since I am responsible for the UI design, and our web page has not connected to the database that store the
#book information, this code is only for testing whether the controller has grab the example data correctly or not.


describe ImdbController do
  before do
    @imdbcontroller = ImdbController.new
  end

  describe "#image" do
    it "test if we get the correct image" do
      @imdbcontroller.bookimage.must_equal 'java.jpg'
    end
  end

  describe "#tag" do
    it "test if we get the correct tag" do
      @imdbcontroller.tag1.must_equal 'tag1'
    end
  end

  describe "#name" do
    it "test if we get the correct book name" do
      @imdbcontroller.book_name.must_equal = 'Java 7 Programming'
    end
  end

end
