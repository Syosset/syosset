class CollaboratorGroup
  include Mongoid::Document

  groupify :group, members: [:users], default_members: :users
	belongs_to :collaboratable, polymorphic: true
end
