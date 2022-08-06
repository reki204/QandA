require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'question' do
    before do
      @question = build(:question)
    end
  end
  context 'when valid parameters' do
    it 'all fields are filled in' do
      expect(@question).to be_valid
    end
  end
  context 'when invalid parameters' do
    it 'not all fields are filled in.' do
      @question = Question.new
      expect(@question.save).to be_falsey
    end
  end
end
