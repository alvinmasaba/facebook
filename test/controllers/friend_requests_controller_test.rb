require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'new_friend_request_path creates a friend request' do
    sign_in users(:alvin)
    post friend_requests_url(:sender => users(:alvin), :recipient => users(:francis))

    assert_redirected_to dashboard_url
  end
end