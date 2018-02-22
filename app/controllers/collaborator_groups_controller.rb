class CollaboratorGroupsController < ApplicationController
  before_action :set_collaborator_group

  def edit
    authorize @collaborator_group.collaboratable
  end

  def update
    authorize @collaborator_group.collaboratable
    @collaborator_group.update!(collaborator_group)
    redirect_to collaborator_group.collaboratable, flash: { success: 'Collaborators have been updated' }
  end

  private
  def set_collaborator_group
    @collaborator_group = CollaboratorGroup.find(params[:id])
  end

end
