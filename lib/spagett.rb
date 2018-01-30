class Spagett

  def initialize(host)
    @connection = host.empty? ? nil : Faraday.new(:url => host)
  end

  def on_thread(thread)
    @connection.post '/threads', {id: thread.id.to_s, user_name: thread.user.name} unless @connection.nil?
  end

  def on_message(message)
    @connection.post "/threads/#{message.message_thread.id.to_s}/messages", message.to_json unless @connection.nil?
  end

end