require 'faker'

class FakeData
  attr_accessor :comment_hash_list, :user_hash_list
  def initialize
    @comment_hash_list = []
    @user_hash_list = []
  end
  def user_generator(num)
    (1..num).each do |i|
      username = Faker::Name.first_name + " " + Faker::Name.last_name
      display_name = Faker::Lorem.word
      password = "1"
      email = Faker::Internet.email
      admin = "0"
      @user_hash_list.push({"username" => username, "display_name" => display_name, \
        "password" => password, "email" => email, "admin" => admin})
    end
  end
  def book_comment_generator(first_user_id, last_user_id, first_book_id, last_book_id, num)
    (1..num).each do
      (first_book_id..last_book_id).each do |i|
        user_id = Faker::Number.between(first_user_id, last_user_id)
        book_id = i
        title = Faker::Hacker.say_something_smart.split(',')[0]
        body = Faker::Hacker.say_something_smart
        like = Faker::Number.between(-10, 10000).to_s
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
