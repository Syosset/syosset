$redis = Redis.new(url: ENV['REDIS_URL'])
Resque.redis = $redis
Syosset::Application.configure do
  config.peek.adapter = :redis, {
    client: $redis
  }
end
