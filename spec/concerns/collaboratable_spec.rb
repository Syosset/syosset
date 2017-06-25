require 'rails_helper'

RSpec.describe Concerns::Collaboratable do
    let(:group) {create(:collaborator_group)}

    it "tells scram to allow collaborators to edit the model" do
      model = group.collaboratable
      member = build(:user)
      model.collaborator_group.add member
      expect(member.can?(:edit, model)).to be true
    end

end
