require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let(:user) { create :user }
  let!(:question) { create :question, user: user }
  let!(:answer) { create :answer, user_id: user.id, question_id: question.id }
  let(:valid_answer_params) { attributes_for(:answer, user_id: user.id, question_id: question.id) }

  before do
    sign_in user
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get edit_question_answer_path(question.answers.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    it 'returns http status found' do
      post question_answers_path, params: { answer: valid_answer_params }
      expect(response).to have_http_status(:found)
    end

    it 'increases answer count' do
      expect { post question_answers_path, params: { answer: valid_answer_params } }.to change(Answer, :count).by(+1)
    end

    context 'when question' do
      it 'redirects answered question page' do
        post question_answers_path, params: { answer: valid_answer_params }
        expect(response).to redirect_to question_path(question)
      end
    end
  end

  describe 'PUT #update' do
    let!(:answer) { create :answer, user: user, question_id: question.id }
    let(:valid_answer_params) { attributes_for(:answer) }
    it do
      sign_in user
      put answer_path(user.answers.first.id), params: { answer: valid_answer_params }
      expect(response).to have_http_status(:found)
    end

    it do
      sign_in user
      body = '質問への回答'
      valid_answer_params[:body] = body
      expect {
        put answer_path(user.answers.first.id),
            params: { answer: valid_answer_params }
      }.to change { Answer.find(user.answers.first.id).body }.from(user.answers.first.body).to(body)
    end

    it do
      sign_in user
      put answer_path(user.answers.first.id), params: { answer: valid_answer_params }
      expect(response).to redirect_to question_path(question)
    end
  end
end
