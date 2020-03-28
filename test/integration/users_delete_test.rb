require 'test_helper'

class UsersDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "ユーザを削除できること" do
    log_in_as @user
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end
    
end
