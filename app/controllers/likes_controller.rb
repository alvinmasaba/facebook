class LikesController < ApplicationController
  before_action :set_like, only: [:show, :destroy]
  
  def show
    @like
  end

  def destroy
    @like.destroy

    ActionCable.server.broadcast('post', nil)
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end
end

