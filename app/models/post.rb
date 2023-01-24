class Post < ApplicationRecord
  include UserLikeable

  belongs_to :author, class_name: 'User'
  belongs_to :user, optional: true
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_likers, through: :likes, source: :user
  
  accepts_nested_attributes_for :comments, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :likes, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :body
end
