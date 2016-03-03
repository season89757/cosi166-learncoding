require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../lib/api/goodapi'

describe "GoodRead" do
  before do
    @search = GoodR.new(20)
  end

  it "check if result is valid" do
    check = true if @search
    check.must_equal true
  end

  it "check the number of result" do
    @search.results.length.must_equal 20
  end

  it "check the output" do
    target = "Concrete Mathematics: A Foundation for Computer Science"
    result_title = @search.results[0].best_book.title
    result_title.must_equal target
  end
end
#
# class GoodTest < Minitest::Test
#   def setup
#     @search = GoodR.new(20)
#   end
#
#   def test_goodreads_output_valid
#     assert @search.results
#   end
#
#   def test_goodreads_output_num
#     assert_equal @search.results.length,20
#   end
#
#   def test_goodreads_output
#     target = "Concrete Mathematics: A Foundation for Computer Science"
#     result_title = @search.results[0].best_book.title
#     assert_equal target,result_title
#   end
# end
