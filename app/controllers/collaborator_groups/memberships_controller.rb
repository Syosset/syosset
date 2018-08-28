class CollaboratorGroups::MembershipsController < ApplicationController
  include CollaboratorGroupScoped
  include UserScoped

  def create
    authorize @collaborator_group.collaboratable, :edit
    @collaborator_group.add(@user)
    redirect_to edit_collaborator_group_path(@collaborator_group), flash: { success: 'Collaborator was added' }
  end

  def destroy
    authorize @collaborator_group.collaboratable, :edit
    @collaborator_group.users.delete(@user)
    redirect_to edit_collaborator_group_path(@collaborator_group), flash: { success: 'Collaborator was removed' }
  end
end
