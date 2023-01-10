class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship_1 = Friendship.new((friendship_params))
    @friendship_2 = Friendship.new :user => params[:friend], :friend => params[:user]

    if @friendship_1.save! && @friendship_2.save!
      redirect_to @dashboard
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship_1 = Friendship.where(:user => params[:user])
    @friendship_2 = Friendship.where(:user => params[:friend])
    @friendship.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user, :friend)
  end
end