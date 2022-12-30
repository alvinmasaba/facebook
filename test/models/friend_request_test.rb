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

  test "sending a request adds the recipient to the sender's potential_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:stephanie))
    request.save

    assert request.sender.potential_friends.include?(request.recipient)
  end

  test "sending a request does not add the recipient to the sender's incoming_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:stephanie))
    request.save

    assert_not request.sender.incoming_friends.include?(request.recipient)
  end

  test "receiving a request adds the sender to the recipient's incoming_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:stephanie))
    request.save

    assert request.recipient.incoming_friends.include?(request.sender)
  end

  test "receiving a request does not add the sender to the recipient's potenntial_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:stephanie))
    request.save

    assert_not request.recipient.potential_friends.include?(request.sender)
  end
end
