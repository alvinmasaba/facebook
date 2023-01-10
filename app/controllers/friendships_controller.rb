class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @user = User.find(friendship_params[:user])
    @friendship_1 = Friendship.new(:friend => current_user, :user => @user)
    @friendship_2 = Friendship.new(:friend => @user, :user => current_user)

    if @friendship_1.save! && @friendship_2.save!
      # Friend request is destroyed after accepted.
      @request = FriendRequest.where(sender: @user, recipient: current_user)
      @request.destroy

      redirect_to @dashboard
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship_1 = Friendship.where(user: friendship_params[:user], friend: current_user)
    @friendship_2 = Friendship.where(user: current_user, friend: friendship_params[:user])

    @friendship_1.destroy
    @friendship_2.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user, :friend)
  end
end