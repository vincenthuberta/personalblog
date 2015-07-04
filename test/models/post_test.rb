require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post = @user.posts.build(content: "abc") #user has_many posts. post belongs_to user.
  end

  test "post should be valid" do
    assert @post.valid?
  end
  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  test "content should be present" do
    @post.content = " "
    assert_not @post.valid?
  end
  test "content should be at most 500 characters" do
    @post.content = "a" * 501
    assert_not @post.valid?
  end
  test "order should be most recent first" do
    assert_equal Post.first, posts(:most_recent) 
    #ensure that the first post is the most recent one.
    #it is tested with the mock data at posts.yml
  end
  
end
