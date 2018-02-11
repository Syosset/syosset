class NotifyIntegrationJob < ApplicationJob
  queue_as :integrations

  def perform(integration_id, event, parameters)
    integration = Integration.find(integration_id)
    begin
      integration.create_provider.send(event.to_sym, parameters)
    rescue => error
      integration.failures << IntegrationFailure.new(error: error.message, event: event, parameters: parameters)
      integration.save
      $redis.incr('integration_failures')
    end
  end
end
