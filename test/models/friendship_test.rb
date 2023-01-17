require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  test 'a friendship cannot exist between the same user' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:alvin))
    assert_not friendship.save
  end

  test 'a friendship is between two unique users' do
    friendship = Friendship.new(:user => users(:trevor), :friend => users(:stephanie))
    assert friendship.save
  end

  test 'a friendship adds the friend to the user\'s friends list' do
    friendship = friendships(:one)

    assert friendship.user.friends.include?(friendship.friend)
  end

  test 'a friendship adds the user to the friend\'s friends list' do
    friendship = friendships(:one)

    assert friendship.friend.friends.include?(friendship.user)
  end

  test 'a friendship is mutual' do
    friendship = friendships(:one)

    assert friendship.is_mutual
  end

  test 'destroying a user destroys the friendship' do
    friendship = friendships(:one)

    # Destroys the user.
    friendship.user.destroy!

    assert_not Friendship.exists?(:id => friendship.id)
  end

  test 'destroying the friend destroys the friendship' do
    friendship = friendships(:one)

    # Destroys the user.
    friendship.friend.destroy!

    assert_not Friendship.exists?(:id => friendship.id)
  end

  test 'destroying the friendship does not destroy the user' do
    friendship = friendships(:one)
    friendship.destroy!

    assert users(:alvin)
  end

  test 'destroying the friendship does not destroy the friend' do
    friendship = friendships(:one)
    friendship.destroy!

    assert users(:stephanie)
  end
end