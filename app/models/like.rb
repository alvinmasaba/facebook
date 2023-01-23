class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true, counter_cache: true
  belongs_to :comment, optional: true, counter_cache: true

  validates :user_id, :uniqueness => { :scope => [:post_id, :comment_id],
    :message => "Users may only like a post once." }
end