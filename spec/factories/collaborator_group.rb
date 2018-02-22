FactoryBot.define do
  factory :collaborator_group do
    collaboratable { |a| a.association(:collaboratable_test_model) }
  end
end
