require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: {session: {email: @user.email, password: "password"}}
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", new_user_path, count: 0
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to login_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", new_user_path
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", logout_path, count: 0
  end
end