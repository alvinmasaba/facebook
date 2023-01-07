class FriendRequestsController < ApplicationController
  def new
    @friend_request = FriendRequest.new
  end

  def create
    @friend_request = FriendRequest.new((friendship_params))

    if @friend_request.save!
      redirect_to @dashboard
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy

    redirect_to @dashboard, status: :see_other
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:sender, :recipient)
  end
end