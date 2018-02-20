require_dependencies 'user/*'

class User
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Slug
  include Concerns::Attachable
  include Authorizable
  include Scram
  include Alerts

  paginates_per 12

  groupify :group_member, group_class_name: 'CollaboratorGroup'

  field :name, type: String
  field :email, type: String

  field :bot, type: Boolean, default: false

  # Profiles
  slug :username
  field :bio, type: String, default: ''
  has_mongoid_attached_file :picture, styles: {
    large: ['512x512', :jpg]
  }, processors: %i[thumbnail compression]
  validates_attachment :picture, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

  # Badges
  belongs_to :badge, optional: true

  # Schedules
  has_many :periods

  def username
    match = email.match(/^([a-z]+)\@.*$/)
    match.nil? ? nil : match[1]
  end

  def staff?
    super_admin || (/^[a-z]+\@syosset\.k12\.ny\.us$/ =~ email).zero?
  end

  def onboarding_steps
    required = []
    if staff?
      required << :picture unless picture.blank?
      required << :bio if bio.blank?
    end
    required
  end
end
