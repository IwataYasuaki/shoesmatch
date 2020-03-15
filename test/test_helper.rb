ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  # テストユーザがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザとしてログインする
  def log_in_as(user, password: 'password', remember_me: '1')
    i = { email: user.email, password: password, remember_me: remember_me }
    post login_path, params: { session: i }
  end
  
end
