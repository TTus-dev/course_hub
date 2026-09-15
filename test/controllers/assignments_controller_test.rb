require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post login_path, params: {
      email: users(:student).email,
      password: "password"
    }

    get assignments_url
    assert_response :success
  end

  test "should get show" do
    post login_path, params: {
      email: users(:student).email,
      password: "password"
    }

    get assignment_url(assignments(:one))
    assert_response :success
  end

  test "should get new" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    get new_assignment_url
    assert_response :success
  end

  test "should get edit" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    get edit_assignment_url(assignments(:one))
    assert_response :success
  end
end
