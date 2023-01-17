class AddFriendRequestsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :num_of_friend_requests, :integer
  end
end
