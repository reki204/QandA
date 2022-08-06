FactoryBot.define do
  factory :answer do
    question
    user
    body { 'answer_body' }
  end
end
