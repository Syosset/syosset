module Syosset
  module Integrations
    module IntegrationProvider

      def friendly_name
        self.class.name.demodulize
      end

      def fa_icon
        friendly_name.downcase
      end

      def options
        Hash.new
      end

      def notify(message)
        raise "not implemented!"
      end

    end
  end
end