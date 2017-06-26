module Admin
  class CollaboratorGroupsController < BaseController
    before_action :get_collaborator_group

    def add_collaborator
    end

    def remove_collaborator
    end

    def edit
      authorize @collaborator_group.collaboratable
    end

    def update
      authorize @collaborator_group.collaboratable
      @collaborator_group.update!(collaborator_group)
      redirect_to collaborator_group.collaboratable, flash: {:success => "Collaborators has been updated"}
    end

    private
    def get_collaborator_group
      @collaborator_group = CollaboratorGroup.find(params[:id])
    end

    def collaborator_group_params
      params.require(:collaborator_group).permit!
    end
  end
end
