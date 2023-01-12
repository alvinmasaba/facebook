class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)
    @post.save
    ActionCable.server.broadcast('post', @post.as_json(include: :author))
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end