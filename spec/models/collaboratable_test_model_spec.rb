require 'rails_helper'

RSpec.describe "Collaboratable Models", type: :model do
  it "can store collaborators" do
    model = create(:collaboratable_test_model)
    member = build(:user)
    model.collaborator_group.add member
    expect(member.in_group?(model.collaborator_group)).to be true
  end
end
