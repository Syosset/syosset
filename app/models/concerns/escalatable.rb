module Concerns
  module Escalatable
    extend ActiveSupport::Concern

    included do
      field :escalated, type: Boolean, default: false
    end

    def request_escalation(user)
      unless EscalationRequest.request_for self
        EscalationRequest.create(requester: user, escalatable: self)
        return true
      end
      false
    end
  end
end
