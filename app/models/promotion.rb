class Promotion
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Paperclip
  include Publishable, Attachable
  include Rankable

  field :enabled, type: Mongoid::Boolean, default: true
  field :text, type: String
  validates :text, presence: true

  has_mongoid_attached_file :picture, styles: {
    thumb: ['250x100', :jpg],
    large: ['1000x400', :jpg]
  }, processors: %i[thumbnail compression]
  validates_attachment :picture, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

  track_history on: [:all]
end
