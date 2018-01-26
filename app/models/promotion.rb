class Promotion
  include Mongoid::Document
  include Mongoid::Paperclip
  include Concerns::Rankable

  field :text, type: String
  field :blurb, type: String, default: ""

  has_mongoid_attached_file :picture, styles: {
    :large => ['1080x350>', :jpg]
  }
  validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

end
