module Syosset
  module Integrations
    module IntegrationProvider

      def options
        return Hash.new
      end

      def notify(message)
        raise "not implemented!"
      end

    end
  end
end