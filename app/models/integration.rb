require_dependencies 'integration/*'

class Integration
  include Mongoid::Document

  def self.providers
    [Syosset::Integrations::Slack]
  end

  field :provider_name, type: String
  validates :provider_name, presence: true

  field :properties, type: Hash
  validates_with IntegrationValidator

  def provider=(provider_class)
    provider_name = provider_class.name
  end

  def provider
    provider_name.constantize
  end

  def create_provider
    provider.send('new', properties)
  end

end
