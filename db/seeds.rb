# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require_relative "../lib/api/goodapi"
#
# require_relative '../lib/api/aws_ecs/amazon-ecs-master/lib/amazon/ecs'
# require 'set'
# require_relative "../lib/api/aws_ecs/aws"

require_relative '../lib/api/google_books_api/google_book_api'


if User.all.length != 0 then User.delete_all end
if Book.all.length != 0 then Book.delete_all end

User.create(username: "liuchao", display_name: "Chao Liu", password: "1", admin: "1", email: "lc89757@brandeis.edu")
User.create(username: "hanzhenyu", display_name: "Zhenyu Han", password: "1", admin: "1", email: "hanzhenyu@brandeis.edu")
User.create(username: "breyerjs", display_name: "Jackson", password: "1", admin: "1", email: "breyerjs@brandeis.edu")
User.create(username: "boyang", display_name: "Boyang", password: "1", admin: "1", email: "ban@brandeis.edu")
User.create(username: "aaaaaa", password: "1", admin: "0", email: "sample@sample.com")
Book.create(title: "Agile Web Development with Rails", author: "Sam Ruby")
Book.create(title: "Don't Make Me Think", author: "Steve Krug")

# Now the api can access all the search results
# but the number of total search results under 'computers' category
# which are the books related to 'programming' is not as much as
# we may imagine, e.g. all the 'ruby programming' books are only 301
# and all the 'java programming' books are 731
test = GoogleBooksAPI.new
test.search('ruby', 200, 'computers')
test.search('java', 500, 'computers')
test.books.each do |b|
  Book.create(title: b.title, author: b.author, ISBN: b.isbn, \
  publish_date: b.publish_date, description: b.description, \
  image_url: b.image_url, publisher: b.publisher, total_pages: b.total_pages, \
  written_language: b.written_language, asin: b.asin, price: b.price, \
  reviews: b.reviews, similar_items: b.similar_items, sale_url: b.sale_url, \
  average_rating: b.average_rating, ratings_count: b.ratings_count, \
  preview_url: b.preview_url, sales_rank: b.sales_rank)
end



# result = GoodR.new(40).results  # range (20-20005.,)
# result.each do |single|
#   title = single.best_book.title
#   author = single.best_book.author.name
#   puts "title:"
#   puts title
#   puts "author"
#   puts author
#   puts "++++++++++"
#   Book.create(title: title, author:author)
# end

# data = Awsapi.new
# data.search('ruby', 10)
# data.books.each do |b|
#   Book.create(title: b.title, author: b.author, ISBN: b.isbn, \
#   publish_date: b.publish_date, description: b.description, \
#   image_url: b.image_url, publisher: b.publisher, total_pages: b.total_pages, \
#   written_language: b.written_language, asin: b.asin, price: b.price)
# end
