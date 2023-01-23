class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  accepts_nested_attributes_for :comments, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :likes, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :body
end
