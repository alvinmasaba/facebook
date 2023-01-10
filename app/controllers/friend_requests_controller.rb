class FriendRequestsController < ApplicationController
  def new
    @friend_request = FriendRequest.new
  end

  def create
    @sender = User.find(friend_request_params[:sender])
    @recipient = User.find(friend_request_params[:recipient])
    @friend_request = FriendRequest.new(:sender => @sender, :recipient => @recipient)

    if @friend_request.save!
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy

    redirect_to dashboard_path, status: :see_other
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:sender, :recipient)
  end
end