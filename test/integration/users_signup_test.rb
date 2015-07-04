require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid sign up information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: " ",
                              email: "saadada@example,com",
                              password: "sadad",
                              password_confirmation: "afqfa" }
    end
    assert_template 'users/new'
  end
  
  test "valid sign up information" do
    get signup_path
    assert_difference 'User.count', 1 do
      #need to state that the post method is via redirect
      post_via_redirect users_path, user: { name: "Vincent",
                              email: "vincent@example.com",
                              password: "whatsup",
                              password_confirmation: "whatsup" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
