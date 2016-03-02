require 'test_helper'

class SearchBoxControllerTest < ActionController::TestCase
  test "should get search_results" do
    get :search_results
    assert_response :success
  end

end
