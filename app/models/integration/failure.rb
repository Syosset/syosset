class Integration::Failure
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :integration

  field :error, type: String

  # event that caused the error
  field :event, type: String

  # hash of parameters passed to the event
  field :parameters, type: Hash
end
