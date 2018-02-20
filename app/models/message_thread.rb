class MessageThread
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages, dependent: :destroy

  field :expires, type: Time, default: 24.hours.from_now
  field :notified, type: Boolean, default: false

  def self.thread_for(user)
    unless (existing_thread = MessageThread.where(user: user, expires: { :$gte => Time.now }).first)
      existing_thread = MessageThread.create(user: user)
    end
    existing_thread
  end

  def notify_spagett
    return if notified

    Integration.notify_all :on_support_thread, thread_id: id.to_s
    update(notified: true)
  end
end
