module User::Collaborator
  extend ActiveSupport::Concern

  included do
    groupify :group_member, group_class_name: 'CollaboratorGroup'
  end
end
