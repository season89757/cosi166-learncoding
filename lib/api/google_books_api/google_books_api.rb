#require 'googlebooks'
require_relative 'GoogleBooks-master/lib/googlebooks.rb'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'amazon/ecs'
require 'json'
require 'goodreads'


class GoogleBooksAPI

attr_accessor :books, :goodreads_client, :books_hash_list

  def initialize
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = 'AKIAIGLTXMSS4JLNHH6A'
      options[:AWS_secret_key] = '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'
      options[:associate_tag] = 'i0a70-20'
    end

    @goodreads_client = Goodreads::Client.new(api_key: "vBvspX3h3XcI5YboURDBg", \
     api_secret: "dMmUn90jCCmBEKvnjuhpvQ7h53dOY6PSt7DX7Gg9Vk")

    @books = []
    @books_hash_list = []
    @file_name =''
  end

  def search(keyword, num_of_results = 100, subject = 'computers')
    @file_name = keyword
    stop_sign = false
    search_times = num_of_results / 10

    search_leftover = num_of_results % 10

    if search_leftover > 0
      search_times += 1
    end

    (1..search_times).each do |current_page|

      books = GoogleBooks.search(keyword + ', subject:' + subject, \
      {:count => 10, :page => current_page })

      books.each do |book|
        new_book = fill_book_info(book)
        @books.push(new_book)
      end

    end
  end

  def fill_book_info(book)
    isbn = book.isbn
    title = book.title
    author = book.authors
    publish_date = book.published_date
    description = book.description
    publisher = book.publisher
    image_url = book.image_link(:zoom => 4)
    total_pages = book.page_count
    written_language = book.language
    average_rating = book.average_rating
    ratings_count = book.ratings_count
    preview_url = book.preview_link

    rest_info = [0, 1, 2, 3]
    #rest_info = fill_tbd_book_info_amazon(title)
    asin = rest_info[0]
    reviews = 'tbd'
    price = rest_info[1]
    #price = book.sale_info['listPrice']
    similar_items = 'tbd'
    sale_url = book.sale_info['buyLink']
    sales_rank = rest_info[3]

    new_book = Bookinfo.new(isbn, title, author, publish_date, description, \
    publisher, image_url, total_pages, written_language, asin, reviews, \
    price, similar_items, sale_url, average_rating, ratings_count, \
    preview_url, sales_rank)

    return new_book
  end

  def fill_tbd_book_info_amazon(title)

    res = Amazon::Ecs.item_search(title, {:response_group => 'Medium', \
     :country => 'us'})

    info_array = []

    asin = res.items[0].get('ASIN')
    price = res.items[0].get('ItemAttributes/ListPrice/FormattedPrice')
    sale_url = res.items[0].get('DetailPageURL')
    sales_rank = res.items[0].get('SalesRank')

    info_array.push(asin)
    info_array.push(price)
    info_array.push(sale_url)
    info_array.push(sales_rank)

    sleep(0.5)

    return info_array
  end

  def get_book_reviews()
  end

  def to_hash(books)

    books.each do |b|
      book_hash = Hash["isbn" => b.isbn, "title" => b.title, "author" => b.author, \
        "publish_date" => b.publish_date, "description" => b.description, \
        "publisher" => b.publisher, "image_url" => b.image_url, "total_pages" => b.total_pages, \
         "written_language" => b.written_language, "asin" => b.asin, "reviews" => b.reviews, \
          "price" => b.price, "similar_items" => b.similar_items, "sale_url" => b.sale_url, \
          "average_rating" => b.average_rating, "ratings_count" => b.ratings_count, "preview_url" => b.preview_url, \
        "sales_rank" => b.sales_rank]
      @books_hash_list.push(book_hash)
    end


  end

  def to_json(books_hash_list)
    File.open((@file_name + "_books.json"),"w") do |f|
      f.write(books_hash_list.to_json)
    end
  end

end

class Bookinfo
  attr_accessor :isbn, :title, :author, :publish_date, :description, \
   :publisher, :image_url, :total_pages, :written_language, :asin, \
   :reviews, :price, :similar_items, :sale_url, :average_rating, \
   :ratings_count, :preview_url, :sales_rank

  def initialize(isbn, title, author, publish_date, description, publisher, \
    image_url, total_pages, written_language, asin, reviews, price, \
    similar_items, sale_url, average_rating, ratings_count, preview_url, \
    sales_rank)
    @isbn = isbn
    @title = title
    @author = author
    @publish_date = publish_date
    @description = description
    @publisher = publisher
    @image_url = image_url
    @total_pages = total_pages
    @written_language = written_language
    @asin = asin
    @reviews = reviews
    @price = price
    @similar_items = similar_items
    @sale_url = sale_url
    @average_rating = average_rating
    @ratings_count = ratings_count
    @preview_url = preview_url
    @sales_rank = sales_rank
  end
end

# books = GoogleBooks.search('ruby' + ', subject:' + 'computers', \
# {:count => 10, :page => 1})
#
# books.each do |i|
#   puts i.isbn
# end

# 9781576760536

test = GoogleBooksAPI.new
test.search('ruby', 80, 'computers')
puts test.books.length
test.to_hash(test.books)
test.to_json(test.books_hash_list)

# test.books.each do |i|
#   puts i.title
# end
# puts test.books.length
# puts test.books[100].title
# test.books.each do |book|
#    puts book.title
#    puts book.price
#    puts book.sale_url
# end

# test = GoogleBooksAPI.new
# aws_info = Amazon::Ecs.item_lookup('0321984137', {:response_group => 'Medium'})
# item = aws_info.get_element("Item").get('ItemAttributes/ListPrice/FormattedPrice')
#
# puts item

# Why not use isbn to search? Just check below out.
# https://books.google.com/books?id=6jyOUrJBJHAC&dq=Refactoring:+Ruby+Edition&source=gbs_navlinks_s
# http://www.amazon.com/Refactoring-Ruby-Addison-Wesley-Professional/dp/0321984137/ref=sr_1_1?ie=UTF8&qid=1458950286&sr=8-1&keywords=Refactoring%3A+Ruby+Edition
# http://www.isbnsearch.org/search?s=0321604170
