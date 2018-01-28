class MessageThread
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages, dependent: :destroy

  field :expires, type: DateTime, default: 24.hours.from_now

  def self.thread_for(user)
    (existing_thread = MessageThread.where(:expires => { :$gte => DateTime.now }).first) ? existing_thread : MessageThread.create(user: user)
  end
end
