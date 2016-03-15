# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative "../lib/api/goodapi"
#require_relative "../lib/api/aws_ecs/aws"

if User.all.length != 0 then User.delete_all end
if Book.all.length != 0 then Book.delete_all end

User.create(username: "liuchao", display_name: "Chao Liu", password: "1", admin: "1", email: "lc89757@brandeis.edu")
User.create(username: "hanzhenyu", display_name: "Zhenyu Han", password: "1", admin: "1", email: "hanzhenyu@brandeis.edu")
User.create(username: "breyerjs", display_name: "Jackson", password: "1", admin: "1", email: "breyerjs@brandeis.edu")
User.create(username: "boyang", display_name: "Boyang", password: "1", admin: "1", email: "ban@brandeis.edu")
User.create(username: "aaaaaa", password: "1", admin: "0", email: "sample@sample.com")
Book.create(title: "Agile Web Development with Rails", author: "Sam Ruby")
Book.create(title: "Don't Make Me Think", author: "Steve Krug")

# result = GoodR.new(20).results
# result.each do |single|
#   title = single.best_book.title
#   author = single.best_book.author.name
#   Book.create(title: author, author:author)
# end

# aws = Awsapi.new
# aws.search("ruby", 10)
# aws.books.each do |b|
#   book = Book.new(title:b.title, author:b.author, image_url:b.image_url,description:b.description)
#   book.save
# end
