module Concerns
  module Escalatable
    extend ActiveSupport::Concern

    included do
      has_many :escalation_requests, :as => :escalatable, :class_name => "EscalationRequest"

      before_destroy do
          escalation_requests.destroy_all
      end
    end


    def request_escalation(user, note)
      unless EscalationRequest.request_for self
        EscalationRequest.create(requester: user, escalatable: self, note: note)
        return true
      end
      false
    end

    def escalated?
      EscalationRequest.approved.where(escalatable: self, :escalation_start_at.lte => Time.now, :escalation_end_at.gte => Time.now).count >= 1
    end

    module ClassMethods
      def escalated(limit=5)
        EscalationRequest.approved.where(escalatable_type: name, :escalation_start_at.lte => Time.now, :escalation_end_at.gte => Time.now).limit(limit).map(&:escalatable).uniq
      end
    end
  end
end
