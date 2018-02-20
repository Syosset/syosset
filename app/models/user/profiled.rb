module User::Profiled
  extend ActiveSupport::Concern
  include Mongoid::Paperclip

  included do
    field :name, type: String
    validates :name, presence: true

    field :email, type: String
    validates :name, presence: true

    has_mongoid_attached_file :picture, styles: { large: ['512x512', :jpg] }, processors: %i[thumbnail compression]
    validates_attachment :picture, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

    field :bio, type: String
  end
end