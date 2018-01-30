class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :message_thread

  field :message, type: String

  def to_json
    {
      id: self.id.to_s,
      sender: {id: self.user.id.to_s, name: self.user.name, picture: self.user.picture.url},
      timestamp: self.created_at,
      message: self.message
    }
  end

  def notify_spagett
    $spagett.on_message self
  end

end
