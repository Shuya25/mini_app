require 'test_helper'

class TwbooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @twbook = twbooks(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Twbook.count' do
      post twbooks_path, params: { twbook: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Twbook.count' do
      delete twbook_path(@twbook)
    end
    assert_redirected_to login_url
  end
end
