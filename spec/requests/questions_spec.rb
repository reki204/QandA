require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user) { create :user, :with_questions }
  let(:question) { user.questions.first }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get questions_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get question_path(question)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get new_question_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #edit' do
    let(:question) { create :question, user: user }
    it 'returns http success' do
      get edit_question_path(question)
      expect(response).to have_http_status(:ok)
    end

    it 'include parameters' do
      get edit_question_path(question)
      expect(response.body).to include question.title
    end
  end

  describe 'POST #create' do
    let(:valid_question_params) { attributes_for(:question) }
    let(:invalid_question_params) { attributes_for(:user, title: '') }

    context 'when valid parameters' do
      it 'returns 302 status' do
        post questions_path, params: { question: valid_question_params }
        expect(response).to have_http_status(:found)
      end

      it 'increases question data' do
        expect { post questions_path, params: { question: valid_question_params } }.to change(Question, :count).by(+1)
      end

      it 'redirects to created question page' do
        post questions_path, params: { question: valid_question_params }
        expect(response).to redirect_to question_path(Question.last)
      end
    end

    context 'when invalid parameters' do
      it 'renders new question page' do
        post questions_path, params: { question: invalid_question_params }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    let!(:question) { create :question, user: user }
    let(:valid_question_params) { attributes_for(:question) }
    context 'when valid parameters' do
      it 'returns 302 status' do
        put question_path(question), params: { question: valid_question_params }
        expect(response).to have_http_status(:found)
      end

      it 'change question title' do
        title = 'question title'
        valid_question_params[:title] = title
        expect {
          put question_path(question),
              params: { question: valid_question_params }
        }.to change { Question.find(question.id).title }.from(question.title).to(title)
      end

      it 'redirects updated question page' do
        put question_path(question), params: { question: valid_question_params }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'when invalid parameters' do
      let(:invalid_question_params) { attributes_for(:question, title: '') }
      it 'renders edit question page' do
        put question_path(question), params: { question: invalid_question_params }
        expect(response).to render_template('edit')
      end
    end
  end
end
