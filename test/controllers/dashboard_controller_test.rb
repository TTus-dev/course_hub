require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    get dashboard_url
    assert_response :success
  end
end
