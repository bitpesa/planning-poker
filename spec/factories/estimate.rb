FactoryBot.define do
  factory :estimate do
    user
    poker_session
    number { 3 }

    trait :skipped do
      skip_vote { true }
    end
  end
end
