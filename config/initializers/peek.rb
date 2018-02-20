module Peek::Views
  class Admin < View
    # admin toggle view
    def initialize(options = {}); end
  end
  class IntegrationFailures < View
    # integration failure count
    def initialize(options = {}); end

    def failure_count
      ::Redis.current.get('integration_failures') || 0
    end
  end
end

Peek.into Peek::Views::Git, nwo: 'Syosset/syosset', sha: ENV['GIT_REV'] || ENV['HEROKU_SLUG_COMMIT']
Peek.into Peek::Views::Admin
Peek.into Peek::Views::Host, host: ENV['HOSTNAME'] || ENV['HEROKU_APP_NAME']
Peek.into Peek::Views::Mongo
Peek.into Peek::Views::Redis
Peek.into Peek::Views::Resque
Peek.into Peek::Views::IntegrationFailures
