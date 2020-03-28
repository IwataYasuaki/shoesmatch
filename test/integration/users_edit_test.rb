require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "不適切な入力の場合、ユーザ情報変更画面に戻ってくること" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    u = { name: "", email: "foo@invalid", prefecture_id: "2",  password: "foo", password_confirmation: "bar" }
    patch user_path(@user), params: { user: u }
    assert_template 'users/edit'
  end

  test "適切な入力の場合、ユーザ情報が更新され、ユーザ情報画面に遷移すること" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    u = { name: name, email: email, prefecture_id: "2", password: "", password_confirmation: "" }
    patch user_path(@user), params: { user: u }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end
