require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'question' do
    before do
      @answer = build(:answer)
    end
  end
  context 'when valid parameters' do
    it 'all fields are filled in' do
      expect(@answer).to be_valid
    end
  end
  context 'when invalid parameters' do
    it 'not all fields are filled in.' do
      @answer = answer.new
      expect(@answer.save).to be_falsey
    end
  end
end
