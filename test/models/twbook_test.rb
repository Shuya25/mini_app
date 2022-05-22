require 'test_helper'

class TwbookTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @twbook = @user.twbooks.build(content: ":orem ipsum")
  end

  test "should be valid" do
    assert @twbook.valid?
  end

  test "user id should be present" do
    @twbook.user_id = nil
    assert_not @twbook.valid?
  end

  test "content should be present" do
    @twbook.content = "   "
    assert_not @twbook.valid?
  end

  test "content should be at most 140 characters" do
    @twbook.content = "a" * 141
    assert_not @twbook.valid?
  end

  test "order should be most recent first" do
    assert_equal twbooks(:most_recent), Twbook.first
  end

end
