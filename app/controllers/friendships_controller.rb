class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friend = User.find(friendship_params[:friend_id])
    @friendship = Friendship.new(:user => current_user, :friend => @friend)

    if @friendship.save!
      # Friend request is destroyed after it is accepted.
      @request = FriendRequest.find_by(sender: @friend.id, recipient: current_user.id)
      @request.destroy

      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friend = User.find(friendship_params[:friend_id])
    @friendship = current_user.find_friendship(@friend)
    @friendship.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end