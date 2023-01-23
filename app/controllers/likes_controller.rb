class LikesController < ApplicationController
  before_action :set_like, only: [:show, :destroy]
  
  def show
    @like
  end

  def destroy
    @like.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Like removed." }
      format.json { head :no_content }
    end
  end

  private

  def set_like
    @like = like.find(params[:id])
  end
end

