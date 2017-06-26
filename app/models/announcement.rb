class Announcement
  include Mongoid::Document
  include Concerns::Descriptable
  include Concerns::Collaboratable

  belongs_to :announceable, polymorphic: true
  belongs_to :poster, class_name: "User"

  class Alert < Subscription::Alert
      belongs_to :poster, class_name: 'User'
      belongs_to :announcement

      validates_presence_of :poster
      validates_presence_of :announcement

      delegate :link, to: :announcement

      def rich_message
        #binding.pry
        [{user: poster, message: " has posted an announcement in a #{announcement.announceable.class.to_s.humanize} you are subscribed to."}]
      end
  end

  def link
    announceable
  end

end
