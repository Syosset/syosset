require_dependencies 'integration/*'

class Integration
  include Mongoid::Document

  def self.providers
    [Syosset::Integrations::Slack, Syosset::Integrations::Spagett].index_by(&:id)
  end

  def self.notify_all(event, parameters)
    Integration.each do |i|
      if i.provider.method_defined? event
        NotifyIntegrationJob.perform_later(i.id.to_s, event.to_s, parameters)
      end
    end
  end

  field :provider_id, type: String
  validates :provider_id, presence: true

  field :options, type: Hash, default: {}
  validates_with IntegrationValidator

  embeds_many :failures, class_name: 'IntegrationFailure'

  def provider
    self.class.providers[provider_id]
  end

  def create_provider
    provider.send('new', options.symbolize_keys)
  end

end
