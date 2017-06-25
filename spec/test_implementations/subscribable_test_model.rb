# Test model for testing real models which can be subscribed
class SubscribableTestModel
  include Mongoid::Document
  include Concerns::Subscribable
end
