require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      user_params = { name: "",
                      email: "user:invalid",
                      prefecture_id: "1",
                      password: "foo",
                      password_confirmation: "bar" }
      post users_path, params: { user: user_params }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      user_params = { name: "Example User",
                      email: "user00@example.com",
                      prefecture_id: "1",
                      password: "password",
                      password_confirmation: "password" }
      post users_path, params: { user: user_params }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
