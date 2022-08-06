FactoryBot.define do
  factory :user do
    username { 'username' }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'password' }
    profile { 'profile' }
    profile_image_id { 'profile_image_id' }
  end

  trait :with_questions do
    after(:create) do |user|
      user.questions << FactoryBot.create(:question)
    end
  end
end
