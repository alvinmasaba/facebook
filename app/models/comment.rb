class Comment < ApplicationRecord
  include UserLikeable

  default_scope { order(created_at: :asc) }
  
  belongs_to :post, counter_cache: true
  belongs_to :parent_comment, class_name: 'Comment'
  belongs_to :commenter, class_name: 'User'
  has_many :likes
  has_many :user_likers, through: :likes, source: :user
  has_many :comments

  accepts_nested_attributes_for :likes, allow_destroy: true, reject_if: :all_blank
  
  validates_presence_of :body
end
