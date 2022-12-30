class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, class_name: 'User'
  
  validates_presence_of :body
end
