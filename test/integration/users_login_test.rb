require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "有効なユーザ情報でログインし、その後ログアウトできること" do
    # ログイン
    get login_path
    assert_template 'sessions/new'
    params = { session: { email: @user.email, password: "password" } }
    post login_path, params: params
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    # ログアウト
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # 別のタブでログアウト
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "「次回から自動的にログインする」をチェックしてログインした場合、" +
       "記憶トークンのクッキーが存在すること" do
    log_in_as @user, remember_me: '1'
    assert_not_empty cookies['remember_token']
  end

  test "「次回から自動的にログインする」をチェックせずログインした場合、" +
       "記憶トークンのクッキーが存在しないこと" do
    # まずはチェックありでログインし、記憶トークンのクッキーを作る
    log_in_as @user, remember_me: '1'
    # ログオフし、記憶トークンのクッキーを削除
    delete logout_path
    # 今度はチェックなしでログイン
    log_in_as @user, remember_me: '0'
    assert_empty cookies['remember_token']
  end
end
