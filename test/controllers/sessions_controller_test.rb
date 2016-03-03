require_relative '../test_helper'
require 'minitest/autorun'
require 'rails/all'
#require_relative '../../app/controllers/sessions_controller'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @sessions_controller = SessionsController.new
    @test_user = User.create(username: "faker",
                             email: "test@test.com",
                             password: "password")
  end

  test "create successfully" do
    assert_not_nil(@sessions_controller)
  end

  test "the create method works" do
    assert(@sessions_controller.create_test("faker",@test_user.password))
    assert_not(@sessions_controller.create_test("not exist user", "whatever"))
  end

end
