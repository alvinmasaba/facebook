class FriendRequest < ApplicationRecord
  # - RELATIONS
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  # - VALIDATIONS
  validates_presence_of :sender_id, :recipient_id
  validate :sender_is_not_recipient
  validates_uniqueness_of :sender_id, scope: [:recipient_id]

  private

  def sender_is_not_recipient
    errors.add(:sender, "Cannot be the same as the sender") if self.sender == self.recipient
  end
end
