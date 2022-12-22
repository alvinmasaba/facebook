class DashboardController < ActionController::Base
  before_action :display_or_redirect
  before_action :authenticate_user!

  def show
  end

  private

  def display_or_redirect
    redirect_to new_user_session_path unless current_user
  end
end
