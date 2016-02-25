# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username: "liuchao", display_name: "Chao Liu", password: "1", email: "lc89757@brandeis.edu")
User.create(username: "hanzhenyu", display_name: "Zhenyu Han", password: "1", email: "hanzhenyu@brandeis.edu")
Book.create(title: "Agile Web Development with Rails", author: "Sam Ruby")
Book.create(title: "Don't Make Me Think", author: "Steve Krug")
