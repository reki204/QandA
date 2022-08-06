FactoryBot.define do
  factory :question do
    user
    title { 'question_title' }
    body { 'question_body' }
    image { 'image' }
  end
end
