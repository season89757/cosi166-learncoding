require 'amazon/ecs'
require 'set'

class Awsapi
  attr_accessor :books, :return_num

  def initialize()
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = 'AKIAIGLTXMSS4JLNHH6A'
      options[:AWS_secret_key] = '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'
      options[:associate_tag] = 'i0a70-20'
    end
    @books = []
  end

  def search(keyword, result_num)
    if result_num <= 0
      return false
    end

    @res = Amazon::Ecs.item_search(keyword, {:response_group => 'Medium', \
      :country => 'us', :power => "subject:computers", :item_page => '1', \
      :sort => 'relevancerank'})

    max_results = @res.total_results

    if result_num > max_results
      puts "Please enter a valid result_num which <= #{max_results}."
      return false
    end

    search_times = result_num / 10
    leftover = result_num % 10

    (1..result_num).each do |i|
      num = i.to_s
      @res = Amazon::Ecs.item_search(keyword, {:response_group => 'Medium', \
        :country => 'us', :power => "subject:computers", :item_page => num, \
        :sort => 'relevancerank'})

      @res.items.each do |item|
        book = fill_book_info(item)
        @books.push(book)
      end
    end

    if leftover > 0
      num = (search_times + 1).to_s
      @res = Amazon::Ecs.item_search(keyword, {:response_group => 'Medium', \
        :country => 'us', :power => "subject:computers", :item_page => num, \
        :sort => 'relevancerank'})

      @res.items[0..leftover - 1].each do |item|
        book = fill_book_info(item)
        @book.push(book)
      end
    end

  end

  def fill_book_info(item)
    isbn = item.get('ItemAttributes/ISBN')
    title = item.get('ItemAttributes/Title')
    author = item.get_array('ItemAttributes/Author')
    publish_date = item.get('ItemAttributes/PublicationDate')
    description = item.get('EditorialReviews/EditorialReview/Content')
    publisher = item.get('ItemAttributes/Publisher')
    image_url = item.get('LargeImage/URL')
    total_pages = item.get('ItemAttributes/NumberOfPages')
    written_language = item.get_array('Languages/Language/Name').to_set.to_a
    asin = item.get('ASIN')
    reviews = "tbd"
    price = item.get('ItemAttributes/ListPrice/FormattedPrice')

    book = Book.new(isbn, title, author, publish_date, description, \
    publisher, image_url, total_pages, written_language, asin, reviews, \
    price)

    return book
  end

end

class Book
  attr_accessor :isbn, :title, :author, :publish_date, :description, \
   :publisher, :image_url, :total_pages, :written_language, :asin, \
   :reviews, :price

  def initialize(isbn, title, author, publish_date, description, publisher, \
    image_url, total_pages, written_language, asin, reviews, price)
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
  end
end
