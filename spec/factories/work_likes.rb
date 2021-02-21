FactoryBot.define do
  factory :work_like do
    association :user
    association :work
  end
end
