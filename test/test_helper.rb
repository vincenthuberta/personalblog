ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def setup
    @user = users(:michael)
  end
  
  # Logs in a test user.
  def log_in_as(user, options = {})
      password = options[:password] || 'password'
      remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email: user.email,
      password: password,
      remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end
  
  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end
  
  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
  
  private
    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
end
