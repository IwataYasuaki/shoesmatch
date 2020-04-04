class ShoesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def index
    @shoes = Shoe.all
  end

  def show
    @shoe = Shoe.find(params[:id])
  end

  def create
    @shoe = Shoe.new(shoe_params)
    @shoe.user = current_user
    @shoe.shoe_status = ShoeStatus.new(status: "登録済み")
    if @shoe.save
      flash[:success] = "靴を登録しました。"
      redirect_to @shoe
    else
      render 'new'
    end
  end

  def new
    @shoe = Shoe.new
  end

  def edit
    @shoe = Shoe.find(params[:id])
  end

  def update
    @shoe = Shoe.find(params[:id])
    if @shoe.update(shoe_params)
      flash[:success] = "靴情報を変更しました。"
      redirect_to @shoe
    else
      render 'edit'
    end
  end

  def destroy
    @shoe = shoe.find(params[:id])
    if @shoe.destroy
      flash[:success] = "靴を削除しました。"
      redirect_to root_url
    else
      render 'show'
    end
  end

  private

    def shoe_params
      params.require(:shoe).permit(:left_size, :right_size, :maker, :name, :description)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

end
