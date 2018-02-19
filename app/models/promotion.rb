class Promotion
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Paperclip
  include Concerns::Attachable
  include Concerns::Rankable

  field :enabled, type: Mongoid::Boolean, default: true
  field :text, type: String
  field :blurb, type: String, default: ''

  has_mongoid_attached_file :picture, styles: {
    :thumb => ['250x100', :jpg],
    :large => ['1000x400', :jpg]
  }, processors: [:thumbnail, :compression]
  validates_attachment :picture, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

  track_history on: [:all]
end
