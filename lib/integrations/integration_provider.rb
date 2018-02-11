module Syosset
  module Integrations
    module IntegrationProvider
      extend ActiveSupport::Concern

      included do
        def self.friendly_name
          name.demodulize
        end

        def self.id
          friendly_name.downcase
        end

        def self.fa_icon
          friendly_name.downcase
        end
      end

    end
  end
end
