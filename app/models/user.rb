class User
  include Mongoid::Document
  include Scram::Holder

  # Sets up a relation where this user now stores "policy_ids". This is a one-way relationship!
  has_and_belongs_to_many :policies, class_name: "Scram::Policy"
  alias_method :user_policies, :policies # NOTE: This macro remaps the actual mongoid relation to be under the name user_policies, since we override it in User#policies to union in the DEFAULT_POLICIES

  # Overrides Scram::Holder#policies to union in this user's policies along with those default as default policies
  def policies
    Scram::DEFAULT_POLICIES | self.user_policies
  end

  # Defines the compare value used by Scram in the database. We choose to use ObjectIds.
  def scram_compare_value
    self.id
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

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

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

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
end
