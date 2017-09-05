class NotifyIntegrationJob < ApplicationJob
  queue_as :default

  def perform(integration_id, message)
    integration = Integration.find(integration_id)
    begin
      integration.create_provider.notify(message)
    rescue => error
      integration.failures << IntegrationFailure.new(error: error.message, message: message)
      integration.save
      $redis.incr('integration_failures')
    end
  end
end
