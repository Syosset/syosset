# Test model for testing real models which can be subscribed
class SubscribableTestModel
  include Mongoid::Document
  include Concerns::Subscribable

  class Alert < Subscription::Alert
    def link
      "i-love-tests"
    end

    def rich_message
      [{user: user, message: "The tests went well."}]
    end
  end
end
