FactoryGirl.define do
  sequence :email do |_n|
    'tommy#{n}@halloween.com'
  end

  factory :user do
    name 'Tommy Doyle'
    email
    password 'tommydoyle'

    after(:build) do |user, _evaluator|
      user.user_policies << FactoryGirl.build(:policy, :collaborator, context: CollaboratableTestModel.to_s)
    end

    trait :admin_panel_acess do
      after(:build) do |user, _evaluator|
        user.user_policies << FactoryGirl.build(:policy, :admin_info)
      end
    end

    trait :super_admin do
      after(:build) do |user, _evaluator|
        user.super_admin = true
      end
    end

    factory :user_with_alerts do
      transient do
        alerts_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:alert, evaluator.alerts_count, user: user)
      end
    end
  end
end
