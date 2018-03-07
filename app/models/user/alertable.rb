module User::Alertable
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, class_name: 'Subscription'
    has_many :alerts
  end
end