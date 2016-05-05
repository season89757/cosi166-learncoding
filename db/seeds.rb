# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require_relative '../lib/scripts/parse_json_book_info'
require_relative '../lib/scripts/image_processing'
require_relative '../lib/scripts/fake_data_generator'

puts "============ Start store seeds data to DB ============"
puts "============ Please wait for about 2 mins ============"

puts "============ Begin to load the User info ============"
if User.all.length != 0 then User.delete_all end
if Book.all.length != 0 then Book.delete_all end

User.create(username: "liuchao", display_name: "Chao Liu", password: "1", admin: "1", email: "lc89757@brandeis.edu")
User.create(username: "hanzhenyu", display_name: "Zhenyu Han", password: "1", admin: "1", email: "hanzhenyu@brandeis.edu")
User.create(username: "breyerjs", display_name: "Jackson", password: "1", admin: "1", email: "breyerjs@brandeis.edu")
User.create(username: "boyang", display_name: "Boyang", password: "1", admin: "1", email: "ban@brandeis.edu")
User.create(username: "aaaaaa", password: "1", admin: "0", email: "sample@sample.com")

fake_user = FakeData.new
fake_user.user_generator(200)
fake_user.user_hash_list.each do |u|
  User.create(username: u["username"], display_name: u["display_name"], \
  password: u["password"], email: u["email"], admin: u["admin"])
end
puts "============ User info loaded successfully ============"

puts "============ Begin to load the Book info ============"
book_info = ParseJson.new

file_name_list = ['java', 'c', 'c++', 'c#', 'python', 'php', \
'javascript', 'perl', 'ruby', 'visual basic .net', 'delphi', \
'assembly language', 'objective-c', 'visual basic', 'swift', 'matlab', \
'pl_or_sql', 'r', 'groovy']

book_info.load_info(file_name_list)
book_info.books.each do |b|
  Book.create(title: b.title, author: b.author, ISBN: b.isbn, \
  publish_date: b.publish_date, description: b.description, \
  image_url: b.image_url, publisher: b.publisher, total_pages: b.total_pages, \
  written_language: b.written_language, asin: b.asin, price: b.price, \
  reviews: b.reviews, similar_items: b.similar_items, sale_url: b.sale_url, \
  average_rating: b.average_rating, ratings_count: b.ratings_count, \
  preview_url: b.preview_url, sales_rank: b.sales_rank)
end
puts "============ Book info loaded successfully ============"

puts "============ Begin to load the Comment info ============"
# must generate fake comments after store book info
first_user_id = User.first.id
last_user_id = User.last.id
first_book_id = Book.first.id
last_book_id = Book.last.id

fake_comments = FakeData.new
fake_comments.book_comment_generator(first_user_id, last_user_id, \
first_book_id, last_book_id, 2)

fake_comments.comment_hash_list.each do |comment|
  Comment.create(user_id: comment["user_id"], book_id: comment["book_id"], \
  title: comment["title"], body: comment["body"], like: comment["like"])
end
puts "============ Comment info loaded successfully ============"

puts "============ Begin to load the book like info ============"
fake_book_like = FakeData.new
fake_book_like.book_like_generator(first_book_id, last_book_id)
fake_book_like.book_like_list.each do |like|
  Like.create(user_id: like["user_id"], book_id: like["book_id"])
end
puts "============ Book like info loaded successfully ============"

puts "============ Begin to load the swap info ============"
fake_book_swap = FakeData.new
fake_book_swap.tradeinfo_generator(first_user_id, last_user_id, first_book_id, last_book_id)
fake_book_swap.book_tradein.each do |ti|
  Tradein.create(user_id: ti["user_id"], book_id: ti["book_id"])
end
fake_book_swap.book_tradeoff.each do |to|
  Tradeoff.create(user_id: to["user_id"], book_id: to["book_id"])
end
puts "============ Swap info loaded successfully ============"

puts "============ Begin to load the Image info ============"
#store image to database from app/assets/images folder
image_processing = ImageProcessing.new

logo1_base64 = image_processing.image_processing('imdb_logo30', 'png')
Image.create(name: 'logo1', base64: logo1_base64)

logo2_base64 = image_processing.image_processing('imdb_logo32', 'png')
Image.create(name: 'logo2', base64: logo2_base64)

white_arrow_base64 = image_processing.image_processing('white_arrow', 'png')
Image.create(name: 'white_arrow', base64: white_arrow_base64)

black_arrow_base64 = image_processing.image_processing('black_arrow', 'png')
Image.create(name: 'black_arrow', base64: black_arrow_base64)

home_background_base64 = image_processing.image_processing('homepage_background2', 'png')
Image.create(name: 'background', base64: home_background_base64)

logo3_base64 = image_processing.image_processing('NNL', 'png')
Image.create(name: 'logo_3', base64: logo3_base64)

logo4_base64 = image_processing.image_processing('NNL2', 'png')
Image.create(name: 'logo_4', base64: logo4_base64)

logo5_base64 = image_processing.image_processing('NNL3', 'png')
Image.create(name: 'logo_5', base64: logo5_base64)
puts "============ Image info loaded successfully ============"

puts "============ All seeds data loaded successfully! ============"
