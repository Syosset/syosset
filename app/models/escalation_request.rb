class EscalationRequest
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::Filterable
  include AASM

  belongs_to :requester, class_name: "User"
  belongs_to :reviewer, class_name: "User", optional: true
	belongs_to :escalatable, polymorphic: true

  field :note, type: String

  field :escalation_start_at, type: Time, default: Time.now
  field :escalation_end_at, type: Time, default: Time.now + 1.week

  field :status

  validates_presence_of :requester, :escalatable, :note, :escalation_start_at, :escalation_end_at

  scope :status, -> (status) { where status: status }

  aasm column: :status do
    state :pending, initial: true
    state :approved
    state :denied

    event :approve, after: Proc.new {|reviewer| self.reviewer = reviewer } do
      after do
        EscalationRequest::Alert::Accepted.create(user: self.requester, escalation_request: self)
      end

      transitions from: [:pending, :denied], to: :approved
    end

    event :deny, after: Proc.new {|reviewer| self.reviewer = reviewer } do
      after do
        EscalationRequest::Alert::Denied.create(user: self.requester, escalation_request: self)
      end

      transitions from: [:pending, :approved], to: :denied
    end
  end

  module Alert
    class Base < ::Alert
      belongs_to :escalation_request
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
          [{user: escalation_request.reviewer}, {message: " accepted your escalation request for #{escalatable.send("name") || "a " + escalatable.class.name}" }]
      end
    end

    class Denied < Base
      def rich_message
          [{user: escalation_request.reviewer}, {message: " denied your escalation request for #{escalatable.send("name") || "a " + escalatable.class.name}" }]
      end
    end
  end

  has_many :alerts, dependent: :destroy, class_name: "EscalationRequest::Alert::Base"

  delegate :link, :alert_class, to: :escalatable

  def self.request_for(escalatable)
    EscalationRequest.where(escalatable: escalatable).first
  end


end
