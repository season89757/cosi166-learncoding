require 'faker'

class FakeData
  attr_accessor :comment_hash_list
  def initialize
    @comment_hash_list = []
  end
  def book_comment_generator
    first = Book.first.id
    last = Book.last.id
    
    (first..last).each do |i|
      user_id = Faker::Number.between(1, 100)
      book_id = i
      title =
      body =4
      like =5
    end
  end
end
