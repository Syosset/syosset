# Test model for testing real models which can be escalated
class EscalatableTestModel
  include Mongoid::Document
  include Escalatable
end
