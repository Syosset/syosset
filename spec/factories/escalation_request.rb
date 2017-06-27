FactoryGirl.define do
  factory :escalation_request do
    escalatable { |a| a.association(:escalatable_test_model) }
    requester { build(:user) }
    note "People need this. Believe me."
  end
end
