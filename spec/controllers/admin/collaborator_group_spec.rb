require 'rails_helper'

RSpec.describe Admin::CollaboratorGroupsController, type: :controller do
  login_super_admin
  let(:collaborator_group) { create(:collaborator_group) }
  let(:user) { create(:user) }

  describe "POST add_collaborator" do
    it "adds the collaborator" do
      expect{
        post :add_collaborator, params: { user_id: user.id , collaborator_group_id: collaborator_group.id }
      }.to change(User.in_group(collaborator_group), :count).by(1)
    end
  end

  describe "POST remove_collaborator" do
    it "removes the collaborator" do
      post :add_collaborator, params: { user_id: user.id , collaborator_group_id: collaborator_group.id }
      expect{
        post :remove_collaborator, params: { user_id: user.id , collaborator_group_id: collaborator_group.id }
      }.to change(User.in_group(collaborator_group), :count).by(-1)
    end
  end

end
