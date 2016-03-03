require_relative 'lib/api/aws'
require_relative 'lib/api/goodapi'
require 'pry-byebug'

amaz = Awsapi.new(1).res
goodr = GoodR.new(30).results
binding.pry
puts amaze[0]
