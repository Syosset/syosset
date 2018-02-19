module Syosset
  module Integrations
    class Slack
      include IntegrationProvider

      def initialize(opts = {})
        raise 'Token must be provided.' unless opts and opts.key? :token

        @client = ::Slack::Web::Client.new(opts)
        begin
          raise 'failure' unless @client.api_test['ok']
        rescue Exception
          raise 'Token is not valid.'
        end

        @channel = opts[:channel] || '#general'
      end

      def self.options
        {
          token: {
            type: String,
            required: true
          },
          channel: {
            type: String
          }
        }
      end

      def describe
        "#{@channel} at #{@client.team_info[:team][:domain]}.slack.com"
      end

      def user_signed_in(params)
        authorization = Authorization.find(params[:authorization_id])
        user = authorization.user

        message = "*#{user.name}* (#{user.email}) just signed in with #{authorization.provider}.
          User count is at #{User.count}."
        @client.chat_postMessage(channel: @channel, text: message, as_user: true)
      end
    end
  end
end
