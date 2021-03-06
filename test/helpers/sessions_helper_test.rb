require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "sessionがnilの場合、current_userが正しいユーザを返すこと" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "remember_digestが誤っていた場合、current_userがnilを返すこと" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
