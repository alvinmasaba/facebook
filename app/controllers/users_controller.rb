class UsersController < ApplicationController
  before_action :set_user, only: [:friends]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.limit(10)
  end

  def friends
    @friends = @user.friends
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
