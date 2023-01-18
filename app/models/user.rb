class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :outgoing_friendships, class_name: 'Friendship', foreign_key: 'user_id', dependent: :destroy
  has_many :incoming_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: 'recipient_id'

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, through: :posts, foreign_key: 'commenter_id', dependent: :destroy

  # Incoming friends are users who have sent the user a request
  has_many :incoming_friends, through: :received_requests, source: 'sender'

  # Potential friends are users to whom the user has sent a friend request
  has_many :potential_friends, through: :sent_requests, source: 'recipient'

  def recent_friends_posts
    Post.all
        .includes(:author, :comments)
        .order('created_at')
        .select { |post| self.friends.include?(post.author) || post.author == self }
  end

  def friends
    self.outgoing_friendships.map { |f| User.find(f[:friend_id]) }
                        .concat( self.incoming_friendships.map { |f| User.find(f[:user_id]) })
  end

  def friendships
    self.incoming_friendships.concat(self.outgoing_friendships)
  end

  def pending_friends
    # Pending friends are users in a users outgoing or incoming friend requests.
    self.incoming_friends.concat(self.potential_friends)
  end

  def find_friendship(user)
    # A user may be a friend or a user in a friendship. These columns are interchangeable.
    Friendship.find_by(user: self.id, friend: user.id) || Friendship.find_by(user: user.id, friend: self.id)
  end

  # Search function to search users
  def self.search(search)
    if search
      user_id = User.where("first_name ILIKE :search OR last_name ILIKE :search", search: "%#{search}%")
        if user_id
          self.where(id: user_id)
        else
          @users = User.all
        end
    else
      @user = User.all
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def friend_requests?
    self.num_of_friend_requests > 0
  end

  def pluralize_friend_requests
    "You have #{self.num_of_friend_requests} new friend #{'request'.pluralize(self.num_of_friend_requests)}"
  end
end
