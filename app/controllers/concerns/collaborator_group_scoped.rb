module CollaboratorGroupScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_collaborator_group
  end

  private

  def set_collaborator_group
    @collaborator_group = CollaboratorGroup.find(params[:collaborator_group_id])
  end
end
