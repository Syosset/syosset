module Concerns
  module Collaboratable
    extend ActiveSupport::Concern
    include Scram::DSL::ModelConditions

    included do
      has_one :collaborator_group, as: :collaboratable, dependent: :destroy

      scram_define do
        condition :collaborators do |collaboratable|
          User.in_group(collaboratable.collaborator_group).map(&:scram_compare_value).to_a
        end
      end
    end
  end
end
