FactoryGirl.define do
  sequence :email do |n|
    "tommy#{n}@halloween.com"
  end

  factory :user do
    name "Tommy Doyle"
    email
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
