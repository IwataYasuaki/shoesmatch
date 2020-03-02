class UsersController < ApplicationController
  before_action :set_pref_collection

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :prefecture_id, :password, :password_confirmation)
    end

    def set_pref_collection
      @pref = Prefecture.all.order(:code)
    end
end

