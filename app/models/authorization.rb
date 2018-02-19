class Authorization
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :provider, type: String
  field :uid, type: String

  def self.from_omniauth(auth_hash)
    where(provider: auth_hash['provider'], uid: auth_hash['uid']).first
  end

end