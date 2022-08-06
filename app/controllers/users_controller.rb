class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, only: %i[show edit update]

  def show
    @questions = @user.questions.page(params[:page]).per(3)
  end

  def edit
    if @user != current_user
      redirect_to user_path(@user), alert: '不正なアクセスです。'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新できました。'
    else
      render :edit
    end
  end

  private
    def set_current_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:username, :profile, :image)
    end
end
