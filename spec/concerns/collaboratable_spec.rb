require 'rails_helper'

RSpec.describe Concerns::Collaboratable do

    it "tells scram to allow collaborators to edit the model" do
      collaborator_group = create(:collaborator_group)
      model = collaborator_group.collaboratable
      member = build(:user)
      model.collaborator_group.add member
      expect(member.can?(:edit, model)).to be true
    end

end
