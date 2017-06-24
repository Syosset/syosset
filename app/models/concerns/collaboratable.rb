module Concerns
  module Collaboratable
    extend ActiveSupport::Concern
    include Scram::DSL::ModelConditions

    included do
      has_one :collaborator_group, as: :collaboratable, dependent: :destroy

      scram_define do
        condition :collaborators do |club|
          collaborators_list.members
        end
      end
    end
  end
end
