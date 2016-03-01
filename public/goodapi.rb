require 'goodreads'

class GoodR
  attr_accessor :results
  def initialize(num)
    @key = "vBvspX3h3XcI5YboURDBg"
    @secret = "dMmUn90jCCmBEKvnjuhpvQ7h53dOY6PSt7DX7Gg9Vk"
    @client = Goodreads.new(:api_key => @key)
    @max = 2000
    @results = []
    get(num)
  end

  def get(num)
    if check?(num) then search(num) else search(@max) end
  end

  def check?(num)
    if num <= 2000 then true else false end
  end

  def search(num)
    page = num / 20 - 1
    for n in 0..page do
      r = @client.search_books('computer science',:page => page.to_s)
      r.results.work.each do |single|
        @results << single
      end
    end
  end
end




# @key = "vBvspX3h3XcI5YboURDBg"
# @secret = "dMmUn90jCCmBEKvnjuhpvQ7h53dOY6PSt7DX7Gg9Vk"
# @final = []
#
# #client = Goodreads::Client.new(:api_key => 'KEY', :api_secret => 'SECRET')
# client = Goodreads.new(:api_key => @key) # short version
# for n in 0..4 do
#   search = client.search_books('computer science',:page => n.to_s)
#   search.results.work.each do |single|
#     @final << single
#   end
# end
