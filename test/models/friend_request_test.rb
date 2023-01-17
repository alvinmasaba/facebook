require "test_helper"

class FriendRequestTest < ActiveSupport::TestCase
  test 'a friend request cannot exist between the same user' do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:alvin))
    assert_not request.save
  end

  test 'a friend request is between two unique users' do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    assert request.save
  end

  test "sending a request adds the recipient to the sender's potential_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    request.save

    assert request.sender.potential_friends.include?(request.recipient)
  end

  test "sending a request does not add the recipient to the sender's incoming_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    request.save

    assert_not request.sender.incoming_friends.include?(request.recipient)
  end

  test "receiving a request adds the sender to the recipient's incoming_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    request.save

    assert request.recipient.incoming_friends.include?(request.sender)
  end

  test "receiving a request does not add the sender to the recipient's potential_friends" do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    request.save

    assert_not request.recipient.potential_friends.include?(request.sender)
  end

  test 'a user cannot send the same user more than one request at a time' do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    request.save

    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    
    assert_not request.save
  end

  test 'a user cannot send a request to a user whom has already sent them a request' do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:trevor))
    request.save

    request = FriendRequest.new(:sender => users(:trevor), :recipient => users(:alvin))
    
    assert_not request.save
  end

  test 'a user cannot send a request to their own friends' do
    request = FriendRequest.new(:sender => users(:alvin), :recipient => users(:stephanie))

    assert_not request.save
  end
end
