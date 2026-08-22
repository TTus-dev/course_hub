require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  test "user can log in" do
    visit login_path

    fill_in "Email", with: users(:teacher).email
    fill_in "Password", with: "password"
    click_on "Log in"

    assert_current_path dashboard_path
  end
end
