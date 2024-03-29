class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
    if params[:search] == nil
      @questions = Question.all.page(params[:page]).per(5)
    elsif params[:search] == ''
      @questions = Question.all.page(params[:page]).per(5)
    else
      #部分検索
      @questions = Question.where("body LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(5)
    end
  end

  def show
    @answers = @question.answers.page(params[:page]).per(3)
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to question_path(@question), notice: '質問できました。'
    else
      flash[:alert] = '未入力の項目があります。'
      render :new
    end
  end

  def edit
    cannot_edit_current_user
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question), notice: '更新できました。'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, :image)
    end
end
