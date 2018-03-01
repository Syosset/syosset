module Scram
  class PolicyHolder
    include Mongoid::Document

    belongs_to :policy, class_name: 'Scram::Policy'
    belongs_to :holder, polymorphic: true

    validates_uniqueness_of :holder_id, scope: :policy_id
  end
end
