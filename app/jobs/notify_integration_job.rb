class NotifyIntegrationJob < ApplicationJob
  queue_as :default

  def perform(integration_id, message)
    Integration.find(integration_id).create_provider.notify(message)
  end
end
