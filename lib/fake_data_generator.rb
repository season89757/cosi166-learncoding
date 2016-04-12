require 'faker'

class FakeData
  attr_accessor :comment_hash_list
  def initialize
    @comment_hash_list = []
  end
  def book_comment_generator(first_book_id, last_book_id, num)
    (1..num).each do
      (first_book_id..last_book_id).each do |i|
        user_id = Faker::Number.between(1, 100)
        book_id = i
        title = Faker::Hacker.say_something_smart.split(',')[0]
        body = Faker::Hacker.say_something_smart
        like = Faker::Number.between(-10, 10000)
        @comment_hash_list.push({"user_id" => user_id, "book_id" => book_id, \
          "title" => title, "body" => body, "like" => like})
      end
    end
  end
end

# try = FakeData.new
# try.book_comment_generator(1, 2, 2)
# try.comment_hash_list.each do |comment|
#   puts comment["book_id"]
# end
