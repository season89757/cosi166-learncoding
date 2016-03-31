require 'minitest/autorun'
require_relative '../../lib/api/google_books_api/google_books_api'
require_relative '../test_helper'

describe "google_books_api" do
  before do
    @google_books = GoogleBooksAPI.new
  end

  it "search method and fill_info_method works." do
    @google_books.search('ruby', 30, 'computers')
    books = @google_books.books
    assert_equal(30, books.length)
    books.each do |b|
      assert((b.title.downcase.include? 'ruby') \
      || (b.description.downcase.include? 'ruby'))
    end
  end

end
