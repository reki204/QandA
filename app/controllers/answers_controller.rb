class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :set_answer, only: %i[edit update destroy]

  def create
    answer = @question.answers.build(answer_params)
    answer.user_id = current_user.id
    if answer.save
      redirect_to question_path(@question), notice: 'アドバイスしました。'
    else
      redirect_to question_path(@question), alert: '未入力の項目があります。'
    end
  end

  def edit
    if @question.user != current_user
      redirect_to question_path(@question), alert: '不正なアクセスです。'
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: '更新しました。'
    else
      flash[:alert] = '未入力の項目があります。'
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question), notice: '削除しました。'
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = @question.answers.find(params[:id])
    end

    def answer_params
    params.require(:answer).permit(:body, :question_id)
    end
end
