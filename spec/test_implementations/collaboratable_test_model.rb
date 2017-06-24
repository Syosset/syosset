# Test model for testing real models which can have collaborators
class CollaboratableTestModel
  include Mongoid::Document
  include Concerns::Collaboratable
end
