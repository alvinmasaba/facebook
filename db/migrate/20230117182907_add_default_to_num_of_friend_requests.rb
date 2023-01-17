class AddDefaultToNumOfFriendRequests < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :num_of_friend_requests, :integer, :default => 0
  end
end
