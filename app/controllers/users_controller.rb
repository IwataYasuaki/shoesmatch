class UsersController < ApplicationController
  before_action :set_pref_collection
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザ登録が完了しました。"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザ情報を変更しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "ユーザを削除しました。"
      redirect_to root_url
    else
      render 'show'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :prefecture_id, :password, :password_confirmation)
    end

    def set_pref_collection
      @pref = Prefecture.all.order(:code)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless @user == current_user
    end
end

