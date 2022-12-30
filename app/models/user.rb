class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :outgoing_friendships, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :incoming_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :friends, through: :friendships

  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: 'recipient_id'

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, through: :posts, foreign_key: 'commenter_id', dependent: :destroy

  # Incoming friends are users who have sent the user a request
  has_many :incoming_friends, through: :received_requests, source: 'sender'

  # Potential friends are users to whom the user has sent a friend request
  has_many :potential_friends, through: :sent_requests, source: 'recipient'

  def active_friends
    friends.select { |friend| friend.friends.include?(self) }
  end

  def pending_friends
    # Pending friends are users in a users outgoing or incoming friend requests.
    self.incoming_friends.concat(self.potential_friends)
  end
end
