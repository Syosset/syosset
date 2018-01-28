class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :message_thread

  field :message, type: String

  def to_json
    {
      id: self.id.to_s,
      sender: {id: self.user.id.to_s, name: self.user.name},
      timestamp: self.created_at,
      message: self.message
    }
  end
end
