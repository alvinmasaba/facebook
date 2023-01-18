require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'authenticated users can call new' do
    sign_in users(:alvin)

    get new_friend_request_path(recipient: users(:francis))
    assert_response :success
  end

  test 'unauthenticated users cannot call new' do
    sign_out users(:alvin)

    get new_friend_request_path(recipient: users(:francis))
    assert_redirected_to new_user_session_path
  end
end