module Scram::PolicyHoldable
  extend ActiveSupport::Concern

  included do
    has_many :policy_holders, as: :holder, class_name: "Scram::PolicyHolder"

    define_method :policies do
      ::Scram::DEFAULT_POLICIES | policy_holders.map(&:policy)
    end
  end
end
