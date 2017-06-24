require 'rails_helper'

RSpec.describe "Collaboratable Models", type: :model do
  it "can store collaborators" do
    model = build(:collaboratable_test_model)
    model.collaborator_group = create(:collaborator_group)

    member = build(:user)
    model.collaborator_group.add member
    expect(member.in_group?(model.collaborator_group)).to be true
  end
end
