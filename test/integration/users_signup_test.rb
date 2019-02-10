require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params:{user: {
                            name: "",
                            email: "user@invalid",
                            password: "aaa",
                            password_confirmation: "bbb"}}
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get new_user_path
    assert_difference 'User.count',1 do
      post users_path, params: {user: {
                            name: "Example User",
                            email: "user@example.com",
                            password: "testtest",
                            password_confirmation: "testtest"}}
    end
    follow_redirect!
    assert_template "home/top"
    assert is_logged_in?
  end
end
