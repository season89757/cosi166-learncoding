# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative "../public/goodapi"

User.delete_all
Book.delete_all

User.create(username: "liuchao", display_name: "Chao Liu", password: "1", email: "lc89757@brandeis.edu")
User.create(username: "hanzhenyu", display_name: "Zhenyu Han", password: "1", email: "hanzhenyu@brandeis.edu")
Book.create(title: "Agile Web Development with Rails", author: "Sam Ruby")
Book.create(title: "Don't Make Me Think", author: "Steve Krug")

result = GoodR.new(20).results
result.each do |single|
  Book.create(title: single.best_book.title, author:single.best_book.author.name)
end
