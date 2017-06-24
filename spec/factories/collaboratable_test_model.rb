require "test_implementations/collaboratable_test_model"

FactoryGirl.define do
  factory :collaboratable_test_model do
    after(:build) do |department, evaluator|
      department.collaborator_group = FactoryGirl.build(:collaborator_group)
    end
  end
end
