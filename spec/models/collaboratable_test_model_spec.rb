require 'rails_helper'
require "test_implementations/collaboratable_test_model"

RSpec.describe CollaboratableTestModel, type: :model do
  it "can store collaborators" do
    model = build(:collaboratable_test_model)
    member = build(:user)
    model.collaborator_group.add member
    expect(member.in_group?(model.collaborator_group)).to be true
  end
end
