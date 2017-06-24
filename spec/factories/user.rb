FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "john@doe.com"
    password "tommydoyle"

    after(:build) do |user, evaluator|
      user.user_policies << FactoryGirl.build(:policy, :collaborator, context: CollaboratableTestModel.to_s)
    end

    trait :admin do
      after(:build) do |user, evaluator|
        user.user_policies << FactoryGirl.build(:policy, :admin_info)
      end
    end

  end
end
