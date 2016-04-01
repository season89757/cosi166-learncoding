require 'test_helper'

class PostrepliesControllerTest < ActionController::TestCase
  setup do
    @postreply = postreplies(:one)
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:postreplies)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create postreply" do
  #   assert_difference('Postreply.count') do
  #     post :create, postreply: {  }
  #   end

  #   assert_redirected_to postreply_path(assigns(:postreply))
  # end

  # test "should show postreply" do
  #   get :show, id: @postreply
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit, id: @postreply
  #   assert_response :success
  # end

  # test "should update postreply" do
  #   patch :update, id: @postreply, postreply: {  }
  #   assert_redirected_to postreply_path(assigns(:postreply))
  # end

  # test "should destroy postreply" do
  #   assert_difference('Postreply.count', -1) do
  #     delete :destroy, id: @postreply
  #   end

  #   assert_redirected_to postreplies_path
  # end
end
