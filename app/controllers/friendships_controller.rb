class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy]

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

      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "You have successfully unfriended." }
      format.json { head :no_content }
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end