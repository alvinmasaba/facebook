require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "the friend in a user's friendship is the user's friend" do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    assert friendship.user.friends.include?(friendship.friend)
  end

  test 'recent_friends_posts includes all friends posts' do
    # Posts one, two, and three are authored by users :alvin, :stephanie and :francis, respectfully.
    # Friendship fixtures exists between :alvin and :stephanie, and :alvin and :francis.
    posts = [posts(:one), posts(:two), posts(:three)]

    assert posts.all? { |post| users(:alvin).recent_friends_posts.include?(post) }
  end

  test 'recent_friends_posts does not include posts from non-friends' do
    # Post :four is from a user whom is not friends with :alvin
    posts = [posts(:one), posts(:two), posts(:three), posts(:four)]

    assert_not posts.all? { |post| users(:alvin).recent_friends_posts.include?(post) }
  end

  test 'friend_requests? returns true when user has outstanding requests' do
    FriendRequest.create(:sender => users(:mikey), :recipient => users(:alvin))

    assert users(:alvin).friend_requests?
  end

  test 'friend_requests? returns false when user has no requests' do
    assert_not users(:alvin).friend_requests?
  end
end
