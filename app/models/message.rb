class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :message_thread

  
end
