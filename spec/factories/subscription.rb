FactoryGirl.define do
  factory :subscription do
    subscribable { |a| a.association(:subscribable_test_model) }
  end
end
