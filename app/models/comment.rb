class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, class_name: 'User'
  has_many :likes
  
  validates_presence_of :body
end
