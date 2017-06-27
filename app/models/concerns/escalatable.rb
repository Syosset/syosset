module Concerns
  module Escalatable
    extend ActiveSupport::Concern

    included do
      field :escalated, type: Boolean, default: false
      scope :escalated, -> { where escalated: true }
    end

    def request_escalation(user, note)
      unless EscalationRequest.request_for self
        EscalationRequest.create(requester: user, escalatable: self, note: note)
        return true
      end
      false
    end
  end
end
