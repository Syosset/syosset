module Syosset
  module Integrations
    class Slack
      include IntegrationProvider

      def initialize(opts = {})
        unless opts.key? :token
          raise "No Slack API token provided."
        end

        @client = ::Slack::Web::Client.new(opts)
        @channel = opts[:channel] || '#general'
      end

      def notify(message)
        @client.chat_postMessage(channel: @channel, text: message, as_user: true)
      end

    end
  end
end