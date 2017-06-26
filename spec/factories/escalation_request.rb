FactoryGirl.define do
  factory :escalation_request do
    escalatable { |a| a.association(:escalatable_test_model) }
    requester { build(:user) }
  end
end
