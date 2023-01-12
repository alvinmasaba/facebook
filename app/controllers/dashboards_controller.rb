class DashboardsController < ApplicationController
  def show
    @post = Post.new
    @posts = current_user.recent_friends_posts
  end
end
