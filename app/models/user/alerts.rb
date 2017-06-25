# source: https://github.com/OvercastNetwork/OCN/blob/f706a16409782e3b44b5333c61f88c0b116a4fd9/app/models/user/alerts.rb

class User
  # Stuff related to alerts and subscriptions
  #
  # See also #Alert and #Subscribable
  module Alerts
    extend ActiveSupport::Concern

    included do
      has_many :subscriptions, class_name: 'Subscription'
      has_many :alerts
    end
  end
end
