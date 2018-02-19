class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :message_thread

  field :message, type: String

  def to_json
    {
      id: id.to_s,
      sender: { id: user.id.to_s, name: user.name, picture: user.picture.url },
      timestamp: created_at,
      message: message
    }
  end

  def notify_spagett
    Integration.notify_all :on_support_message, message_id: id.to_s
  end
end
