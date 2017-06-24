FactoryGirl.define do
  factory :user do
    name "John Doe"

    trait :admin do
      after(:build) do |user, evaluator|
        user.user_policies << FactoryGirl.build(:policy, :admin_info)
      end
    end
  end
end
