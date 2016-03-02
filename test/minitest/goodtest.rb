require 'minitest/autorun'
require_relative '../../public/goodapi'
require 'pry-byebug'

class GoodTest < Minitest::Test
  def setup
    @search = GoodR.new(20)
  end

  def test_goodreads_output_valid
    assert @search.results
  end

  def test_goodreads_output_num
    assert_equal @search.results.length,20
  end

  def test_goodreads_output
    target = "Concrete Mathematics: A Foundation for Computer Science"
    result_title = @search.results[0].best_book.title
    assert_equal target,result_title
  end
end
