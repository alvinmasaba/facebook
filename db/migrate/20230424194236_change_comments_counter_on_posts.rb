class ChangeCommentsCounterOnPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :comments_count, :integer, :default => 0
  end
end
