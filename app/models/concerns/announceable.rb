module Concerns
  module Announceable
    extend ActiveSupport::Concern

    included do
      has_many :announcements, :as => :announceable, :class_name => "Announcement"

      before_destroy do
        announcements.destroy_all
      end
    end

    def alert_class
      Announcement::Alert
    end

    def announce(poster, name, short_description, content)
      announcement = Announcement.create(announceable: self, poster: poster, name: name, short_description: short_description, content: content)
      #binding.pry
      if self.is_a? Subscribable
        self.alert_subscribers(announcement: announcement, poster: poster)
      end
    end
  end
end
