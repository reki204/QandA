class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.page(params[:page]).per(3)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user), alert: '不正なアクセスです。'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新できました。'
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :profile, :image)
    end

end