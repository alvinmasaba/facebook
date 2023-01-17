class FriendRequest < ApplicationRecord
  # - RELATIONS
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User', counter_cache: :num_of_friend_requests

  # - VALIDATIONS
  validates_presence_of :sender_id, :recipient_id
  validate :sender_is_not_recipient
  validate :request_is_unique
  validate :recipient_is_not_friend
  validates_uniqueness_of :sender_id, scope: [:recipient_id]

  private

  def sender_is_not_recipient
    errors.add(:sender, "Cannot be the same as the sender") if self.sender == self.recipient
  end

  def request_is_unique
    errors.add(:sender, "Request is already pending. Check your friend requests.") if FriendRequest.exists?(:sender => self.recipient, :recipient => self.sender)
  end

  def recipient_is_not_friend
    errors.add(:sender, "Cannot send request to active friend.") if self.sender.friends.include?(self.recipient)
  end
end
