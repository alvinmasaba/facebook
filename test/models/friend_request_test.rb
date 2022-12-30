require "test_helper"

class FriendRequestTest < ActiveSupport::TestCase
  test 'a friend request cannot exist between the same user' do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:alvin))
    assert_not request.save
  end

  test 'a friend request is between two unique users' do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:stephanie))
    assert request.save
  end
end
