require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    get courses_list_url
    assert_response :success
  end

  test "should get show" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    get courses_show_url(courses(:ruby_basics))
    assert_response :success
  end

  test "should get new" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    get courses_new_url
    assert_response :success
  end

  test "should get create" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    post courses_url, params: {
      course: {
        name: "Test Course",
        description: "Test description",
      }
    }
    assert_redirected_to my_courses_path
  end
end
