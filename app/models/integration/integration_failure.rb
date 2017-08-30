class IntegrationFailure
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :integration

  field :error, type: String

  # message being sent that caused the error
  field :message, type: String

end