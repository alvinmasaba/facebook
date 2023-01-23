class AddNullToLikesColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :likes, :post_id, :bigint, null: true
    change_column :likes, :post_id, :bigint, null: true
  end
end
