FactoryGirl.define do
  factory :policy, class: Scram::Policy do
    name 'New Policy'

    trait :admin_info do
      after(:build) do |policy, evaluator|
        policy.targets.build(conditions: {equals: {:'*target_name' => 'admin_panel'}}, actions: ['view'])
      end
    end

    trait :collaborator do
      after(:build) do |policy, evaluator|
        policy.targets.build(conditions: {:includes => {:'*collaborators' => '*holder'}}, actions: ['edit'])
      end
    end
  end
end
