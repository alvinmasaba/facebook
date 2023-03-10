class Comment < ApplicationRecord
  include UserLikeable
  
  belongs_to :post
  belongs_to :commenter, class_name: 'User'
  has_many :likes
  has_many :user_likers, through: :likes, source: :user

  accepts_nested_attributes_for :likes, allow_destroy: true, reject_if: :all_blank
  
  validates_presence_of :body
end
