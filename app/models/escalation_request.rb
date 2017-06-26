class EscalationRequest
  include Mongoid::Document
  include AASM

  belongs_to :requester, class_name: "User"
  belongs_to :reviewer, class_name: "User", optional: true
	belongs_to :escalatable, polymorphic: true

  field :status

  validates_presence_of :requester, :escalatable

  aasm column: :status do
    state :pending, initial: true
    state :approved
    state :denied

    event :approve, after: Proc.new {|reviewer| self.reviewer = reviewer } do
      after do
        EscalationRequest::Alert::Accepted.create(user: self.requester, escalation_request: self)
        self.escalatable.update!(escalated: true)
      end

      transitions from: :pending, to: :approved
    end

    event :deny, after: Proc.new {|reviewer| self.reviewer = reviewer } do
      after do
        EscalationRequest::Alert::Denied.create(user: self.requester, escalation_request: self)
      end

      transitions from: :pending, to: :denied
    end
  end

  module Alert
    class Base < ::Alert
      belongs_to :escalation_request, index: true, validate: true
      field :escalatable_type, type: String

      validates_presence_of :escalatable
      validates_presence_of :escalatable_type

      delegate :link, :escalatable, to: :escalation_request

      before_validation do
        if escalation_request
          self.user = escalation_request.requester
          self.escalatable_type = escalation_request.escalatable_type
        end
      end
    end

    class Accepted < Base
      def rich_message
          [{user: escalation_request.reviewer}, {message: " denied your escalation request" }]
      end
    end

    class Denied < Base
      def rich_message
          [{message: "Your request to escalate a " + escalatable_type + " was denied by " + escalation_request.reviewer.name }]
      end
    end
  end

  delegate :link, :alert_class, to: :escalatable

  def self.request_for(escalatable)
    EscalationRequest.where(escalatable: escalatable).first
  end


end
