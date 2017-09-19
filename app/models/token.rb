class Token
  include Mongoid::Document
  delegate :can?, to: :user
  delegate :cannot?, to: :user

  belongs_to :user

  field :key, type: String
end
