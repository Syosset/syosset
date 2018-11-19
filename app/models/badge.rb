class Badge
  include Mongoid::Document

  field :name, type: String
  field :color, type: String, default: 'e8e8e8'
  field :icon, type: String, default: 'fa-shield-alt'

  validates :name, length: { maximum: 20 }
  validates :color, length: { is: 6 }
  validates :icon, presence: true
end
