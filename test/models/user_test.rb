require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "the friend in a user's friendship is the user's friend" do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    assert friendship.user.friends.include?(friendship.friend)
  end

  test 'destroying a user destroys the friendship' do
    user = users(:alvin)

    # Creates and saves a friendship.
    friendship = Friendship.new(:user => user, :friend => users(:stephanie))
    friendship.save

    # Destroys the user.
    user.destroy!

    assert_not Friendship.exists?(:id => friendship.id)
  end

  test 'destroying the friend destroys the friendship' do
    friend = users(:alvin)

    # Creates and saves a friendship.
    friendship = Friendship.new(:user => users(:stephanie), :friend => friend)
    friendship.save

    # Destroys the user.
    friend.destroy!

    assert_not Friendship.exists?(:id => friendship.id)
  end

  test 'destroying the friendship does not destroy the user' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    friendship.destroy!

    assert users(:alvin)
  end

  test 'destroying the friendship does not destroy the friend' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:stephanie))
    friendship.save

    friendship.destroy!

    assert users(:stephanie)
  end
end
