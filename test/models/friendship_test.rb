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

  test 'a friendship adds the friend to the user\'s friends list' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    assert friendship.user.friends.include?(friendship.friend)
  end

  test 'a friendship adds the user to the friend\'s friends list' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    assert friendship.friend.friends.include?(friendship.user)
  end

  test 'a friendship is mutual' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    assert friendship.is_mutual
  end
end