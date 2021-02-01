FactoryBot.define do
  factory :work do
    title { "test_title" }
    content { "test_content" }
    association :user
  end
end