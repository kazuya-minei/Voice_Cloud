FactoryBot.define do
  factory :comment do
    association :user
    association :voice
    comment { "Coooool!!!" }
  end
end
