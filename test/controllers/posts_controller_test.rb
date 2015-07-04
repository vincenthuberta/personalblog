require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get _new_post" do
    get :_new_post
    assert_response :success
  end

  test "should get _edit_post" do
    get :_edit_post
    assert_response :success
  end

end
