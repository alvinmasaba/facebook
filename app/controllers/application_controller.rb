class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  # Store last page for redirecting to last page on log in or log out.
  before_action :store_user_location!, if: :storable_location?

  protect_from_forgery prepend: true
  
  # To enable sign in to function correctly.
  skip_before_action :verify_authenticity_token, :only => :create

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :encrpyted_password, :password_confirmation, :remember_me]

    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private
  
  def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
  end
end
