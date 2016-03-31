require 'goodreads'

class GoodReadsAPI
  attr_accessor :client
  def initialize
    Goodreads.configure(
    api_key: "vBvspX3h3XcI5YboURDBg",
    api_secret: "dMmUn90jCCmBEKvnjuhpvQ7h53dOY6PSt7DX7Gg9Vk"
    )

    @client = Goodreads::Client.new(api_key: "vBvspX3h3XcI5YboURDBg", \
     api_secret: "dMmUn90jCCmBEKvnjuhpvQ7h53dOY6PSt7DX7Gg9Vk")
  end

  def get_reviews
    return @client.book_by_isbn("9780743273565")
  end
end

test = GoodReadsAPI.new
# book = test.client.book_by_isbn("9780743273565")

book_id = test.client.book_by_isbn("9780743273565").id
puts book_id

reviews = test.client.show_by_isbn("9780743273565")
puts reviews
