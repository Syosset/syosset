class Announcement
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  include Scram::DSL::ModelConditions
  include Descriptable
  include Escalatable
  include Rankable
  include Attachable

  after_create :alert_subscribers

  belongs_to :announceable, polymorphic: true
  belongs_to :poster, class_name: 'User'

  validates :name, presence: true
  validates :markdown, presence: true

  scram_define do
    condition :collaborators do |announcement|
      if announcement.announceable.is_a? Collaboratable
        announcement.announceable.send('*collaborators')
      else
        User.all.select { |u| u.can?(:edit, announcement.announceable) }.map(&:scram_compare_value).to_a
      end
    end
  end

  track_history on: [:all]

  class Alert < Subscription::Alert
    belongs_to :poster, class_name: 'User'
    belongs_to :announcement

    delegate :link, to: :announcement

    def rich_message
      [{ user: poster, message: " has posted an announcement in a #{announcement.announceable.class.to_s.humanize}
        you are subscribed to." }]
    end
  end

  def link
    announceable
  end

  def alert_subscribers
    return unless announceable.is_a? Subscribable
    announceable.alert_subscribers(except: [poster], announcement: self, poster: poster)
  end
end
