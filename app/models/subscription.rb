# source: https://github.com/OvercastNetwork/OCN/blob/master/app/models/subscription.rb
# changes: removed index stuff

class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps

  field :unsubscribed, :type => Boolean, :default => false
  scope :active, -> { where(:unsubscribed.ne => true) }

  def active?
    !unsubscribed?
  end

  belongs_to :subscribable, polymorphic: true, index: true

  belongs_to :user, index: true
  scope :user, -> (value) { where(user: value) }

  class Alert < ::Alert
    belongs_to :subscription, index: true, validate: true
    field :subscription_type, type: String

    validates_presence_of :subscription
    validates_presence_of :subscription_type

    delegate :link, :subscribable, to: :subscription

    before_validation do
      if subscription
        self.user = subscription.user
        self.subscription_type = subscription.subscribable_type
      end
    end

    # Combine a newer alert for the same subscription into this one.
    # Return true if the new alert should be kept, false to discard it.
    # The base implementation destroys self and returns true.
    def combine(newer)
        destroy
        true
    end
  end
  has_many :alerts, class_name: 'Subscription::Alert'

  before_destroy do
      alerts.destroy_all
  end

  validates_presence_of :user
  validates_presence_of :subscribable

  # Pass the class of the subscribable
  scope :subscribable_type, -> (type) { where(subscribable_type: type.name) }

  class << self
    def alerts
      Alert.in(subscription: all.to_a)
    end
  end

  delegate :link, :alert_class, to: :subscribable

  # Send an alert for this subscription, if it is active, and the subscriber is
  # allowed to view the subscribable object, and the subscriber is not passed
  # in the :except: argument.
  def alert_subscriber(except: nil, **opts)
    if active? && ![*except].include?(user) && subscribable.can_view?(user)
      older = alerts.unread.desc(:updated_at).first
      newer = alert_class.new(subscription: self, **opts)
      newer.save! if older.nil? || older.combine(newer)
    end
  end
end
