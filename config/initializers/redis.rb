$redis = Redis.new(url: ENV["REDIS_URL"])
Web::Application.configure do
  config.peek.adapter = :redis, {
      client: $redis
    }
end