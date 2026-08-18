require "test_helper"

class ClassSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get class_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get class_sessions_create_url
    assert_response :success
  end
end
