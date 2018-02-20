# source: https://github.com/OvercastNetwork/OCN/blob/master/app/models/alert.rb
# changes: removed all index stuff for now

class Alert
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  field :read, type: Boolean, default: false
  field :read_at, type: Time

  scope :unread, -> { where(:read.ne => true) }
  scope :user, ->(u) { where(user: u) }

  class << self
    def mark_read!
      unread.mark_read_now!
    end

    def mark_read_now!
      update(read: true, read_at: Time.now)
    end
  end

  def mark_read!
    self.class.where(atomic_selector).unread.mark_read_now!
  end

  def link
    Rails.application.routes.url_helpers.root_path
  end

  def rich_message
    [{ message: "<#{self.class} _type=#{self[:_type]}>" }]
  end
end
