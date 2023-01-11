class FriendRequestsController < ApplicationController
  def index
    @received_requests = current_user.received_requests
    @sent_requests = current_user.sent_requests
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
    @recipient = User.find(friend_request_params[:recipient_id])
    @friend_request = FriendRequest.new(:sender => current_user, :recipient => @recipient)

    if @friend_request.save!
      redirect_to dashboard_path, notice: "Friend Request Sent."
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
    params.require(:friend_request).permit(:recipient_id)
  end
end