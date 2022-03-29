require "test_helper"

class ProfileUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get profile_users_show_url
    assert_response :success
  end
end
