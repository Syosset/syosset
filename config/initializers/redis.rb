Redis.current = Redis.new(url: ENV['REDIS_URL'])

Resque.redis = Redis.current
Syosset::Application.configure do
  config.peek.adapter = :redis, {
    client: Redis.current
  }
end
