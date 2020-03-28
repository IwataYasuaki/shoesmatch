require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "ユーザ登録画面を表示できること" do
    get new_user_url
    assert_response :success
  end

  test "ログインしていない状態でユーザ情報画面にアクセスすると" +
       "ログイン画面にリダイレクトされること" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインしていない状態でユーザ情報変更画面にアクセスすると" +
       "ログイン画面にリダイレクトされること" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインしていない状態でユーザ情報を変更しようとすると" +
       "ログイン画面にリダイレクトされること" do
    u = { name: @user.name + "new", email: @user.email, prefecture_id: @user.prefecture_id }
    patch user_path(@user), params: { user: u }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインしていない状態でユーザ情報を削除しようとすると" +
       "ログイン画面にリダイレクトされること" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "他のユーザのユーザ情報画面にアクセスすると" +
       "トップ画面にリダイレクトされること" do
    log_in_as @other_user
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "他のユーザのユーザ情報変更画面にアクセスすると" +
       "トップ画面にリダイレクトされること" do
    log_in_as @other_user
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "他のユーザのユーザ情報を変更しようとすると" +
       "トップ画面にリダイレクトされること" do
    log_in_as @other_user
    u = { name: @user.name + "new", email: @user.email, prefecture_id: @user.prefecture_id }
    patch user_path(@user), params: { user: u }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "他のユーザを削除しようとすると" +
       "トップ画面にリダイレクトされること" do
    log_in_as @other_user
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
