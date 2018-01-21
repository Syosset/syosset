require_dependencies 'user/*'

class User
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Slug
  include Concerns::Attachable
  include Scram
  include Alerts

  paginates_per 12

  groupify :group_member, group_class_name: 'CollaboratorGroup'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :timeoutable, omniauth_providers: [:google_oauth2]

  # Omniauthable
  field :name

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # Administrator
  field :bot, type: Boolean, default: false

  # Profiles
  slug :username
  field :bio, type: String, default: ""
  has_mongoid_attached_file :picture, styles: {
    :large => ['512x512>', :jpg]
  }
  validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  # Badges
  belongs_to :badge

  # Schedules
  has_many :periods

  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      unless user
           user = User.create(name: data['name'],
              email: data['email'],
              password: Devise.friendly_token[0,20]
           )
      end
      user
  end

  def username
    match = email.match(/^([a-z]+)\@.*$/)
    match.nil? ? nil : match[1]
  end

  def staff?
    super_admin || (/^[a-z]+\@syosset\.k12\.ny\.us$/ =~ email) == 0
  end

  def onboarding_steps
    required = []
    if staff?
      unless picture.present?
        required << :picture
      end
      if bio.empty?
        required << :bio
      end
    end
    required
  end

end
