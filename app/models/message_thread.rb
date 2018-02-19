class MessageThread
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages, dependent: :destroy

  field :expires, type: DateTime, default: 24.hours.from_now
  field :notified, type: Boolean, default: false

  def self.thread_for(user)
    (existing_thread = MessageThread.where(user: user, expires: { :$gte => DateTime.now }).first) ?
      existing_thread : MessageThread.create(user: user)
  end

  def notify_spagett
    unless self.notified
      Integration.notify_all :on_support_thread, thread_id: self.id.to_s
      self.update(notified: true)
    end
  end
end
