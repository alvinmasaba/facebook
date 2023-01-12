class DashboardsController < ApplicationController
  def index
  end

  def show
    @post = Post.new
    @posts = current_user.recent_friends_posts
  end
end
