class Announcement
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  include Scram::DSL::ModelConditions
  include Concerns::Descriptable
  include Concerns::Escalatable
  include Concerns::Rankable
  include Concerns::Attachable

  after_create :alert_subscribers

  belongs_to :announceable, polymorphic: true
  belongs_to :poster, class_name: "User"

  # can be set to hide an announcement from the frontpage slider
  field :slider_hidden, type: Boolean, default: false

  validates_presence_of :name, :markdown

  scram_define do
    condition :collaborators do |announcement|
      if announcement.announceable.is_a? Concerns::Collaboratable
        announcement.announceable.send("*collaborators")
      else
        User.all.select{ |u| u.can?(:edit, announcement.announceable) }.map(&:scram_compare_value).to_a
      end
    end
  end

  track_history on: [:all]

  class Alert < Subscription::Alert
      belongs_to :poster, class_name: 'User'
      belongs_to :announcement

      validates_presence_of :poster
      validates_presence_of :announcement

      delegate :link, to: :announcement

      def rich_message
        [{user: poster, message: " has posted an announcement in a #{announcement.announceable.class.to_s.humanize} you are subscribed to."}]
      end
  end

  def link
    announceable
  end

  def alert_subscribers
    if announceable.is_a? Concerns::Subscribable
      announceable.alert_subscribers(except: [poster], announcement: self, poster: poster)
    end
  end

end
