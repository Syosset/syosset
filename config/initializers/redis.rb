$redis = Redis.new(url: ENV["REDIS_URL"])
Syosset::Application.configure do
  config.peek.adapter = :redis, {
      client: $redis
    }
end