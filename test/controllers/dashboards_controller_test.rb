require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test 'authenticated users can see dashboard' do
    sign_in users(:alvin)

    get dashboard_url
    assert_response :success
  end

  test 'unauthenticated visitors get redirected to login' do
    sign_out users(:alvin)

    get dashboard_url
    assert_redirected_to new_user_session_path
  end
end