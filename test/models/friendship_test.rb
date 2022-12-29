require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'a friendship cannot exist between the same user' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:alvin))
    assert_not friendship.save
  end

  test 'a friendship is between two unique users' do
    friendship = Friendship.new(:user => users(:alvin), :friend => users(:francis))
    assert friendship.save
  end
end