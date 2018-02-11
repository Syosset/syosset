module Syosset
  module Integrations
    class Slack
      include IntegrationProvider

      def initialize(opts = {})
        unless opts and opts.key? :token
          raise "Token must be provided."
        end

        @client = ::Slack::Web::Client.new(opts)
        begin
          unless @client.api_test['ok']
            raise 'failure'
          end
        rescue
          raise 'Token is not valid.'
        end

        @channel = opts[:channel] || '#general'
      end

      def self.options
        {
          :token => {
            type: String,
            required: true
          },
          :channel => {
            type: String
          }
        }
      end

      def describe
        "#{@channel} at #{@client.team_info[:team][:name]}"
      end

      def user_signed_in(params)
        user = User.find(params[:user_id])
        message = "*#{user.name}* (#{user.email}) just signed in with Google. User count is at #{User.count}."
        @client.chat_postMessage(channel: @channel, text: message, as_user: true)
      end

    end
  end
end