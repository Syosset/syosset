module Announceable
  extend ActiveSupport::Concern

  included do
    has_many :announcements, as: :announceable, class_name: 'Announcement'

    before_destroy do
      announcements.destroy_all
    end
  end

  def alert_class
    Announcement::Alert
  end
end
