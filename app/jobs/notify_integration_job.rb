class NotifyIntegrationJob < ApplicationJob
  queue_as :default

  def perform(integration_id, message)
    integration = Integration.find(integration_id)
    begin
      i.create_provider.notify(message)
    rescue => error
      i.failures << IntegrationFailure.new(error: error.message, message: message)
      i.save
      $redis.incr('integration_failures')
    end
  end
end
