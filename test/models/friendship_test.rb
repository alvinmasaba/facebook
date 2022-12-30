require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  test 'a friendship cannot exist between the same user' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:alvin))
    assert_not friendship.save
  end

  test 'a friendship is between two unique users' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    assert friendship.save
  end

  test 'a friendship adds the friend to the users friends list' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    assert friendship.user.friends.include?(friendship.friend)
  end

  test 'the friendship is mutual after two friendship records are created' do
    # Saves two reciprocal friendships to the database.
    friendship = Friendship.new(:user => users(:francis), :friend => users(:alvin))
    friendship.save
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:francis))
    friendship.save

    assert friendship.is_mutual
  end
end