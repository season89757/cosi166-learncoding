require_relative "../api/aws_ecs/aws.rb"
require "rails/all"
#require_relative ""

test_data = Awsapi.new
test_data.search('ruby', 5)
test_data.books.each do |book|
  #Book.create(title: book.title, author: book.title)
  puts book.price.class
end
