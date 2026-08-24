require "test_helper"

class ClassSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    get new_class_session_url(courses(:ruby_basics).id)
    assert_response :success
  end

  test "should get create" do
    post login_path, params: {
      email: users(:teacher).email,
      password: "password"
    }

    post class_sessions_create_url, params: {
      class_session: {
        course_id: courses(:ruby_basics).id,
        topic: "Test Topic",
        description: "Test Description",
        platform: "teams",
        meeting_url: "test_url",
        starts_at: Time.current,
        ends_at: Time.current + 2.hours,
        location_type: "remote"
      }
    }
    assert_redirected_to courses_manage_path(courses(:ruby_basics).id)
  end
end
