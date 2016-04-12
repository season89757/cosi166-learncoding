require 'json'
require_relative 'google_books_api/google_books_api'

class ParseJson
  attr_accessor :books
  def initialize
    @books = []
  end
  def load_info(keywords)
    file_paths = []

    keywords.each do |k|
      path = File.dirname(File.dirname(__FILE__)) + '/save_book_info/' \
             + k + '_books.json'
      file_paths.push(path)
    end

    max = 56
    count = 0

    file_paths.each do |fp|
      file = open(fp)
      json_file = file.read
      parsed_book_info = JSON.parse(json_file)

      parsed_book_info.each do |book|
        isbn = book["isbn"]
        title = book["title"]
        author = book["author"]
        publish_date = book["publish_date"]
        description = book["description"]
        publisher = book["publisher"]
        image_url = book["image_url"]
        total_pages = book["total_pages"]
        written_language = book["written_language"]
        asin = book["asin"]
        reviews = book["reviews"]
        price = book["price"]
        similar_items = book["similar_items"]
        sale_url = book["sale_url"]
        average_rating = book["average_rating"]
        ratings_count = book["ratings_count"]
        preview_url = book["preview_url"]
        sales_rank = book["sales_rank"]
        b = Bookinfo.new(isbn, title, author, publish_date, description, \
            publisher, image_url, total_pages, written_language, asin, \
            reviews, price, similar_items, sale_url, average_rating, \
            ratings_count, preview_url, sales_rank)
        @books.push(b)

        count += 1
        if count == max
          count = 0
          max -= 2
          break
        end

      end

    end

  end

end


# test = ParseJson.new
# file_names = ['ruby']
# test.load_info(file_names)
# test.books.each do |b|
#   puts b.title
# end
