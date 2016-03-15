#require "amazon/ecs"
require_relative "../lib/api/aws_ecs/aws"

aws = Awsapi.new
aws.search("ruby", 15)
aws.books.each do |b|
  puts b.title
end
