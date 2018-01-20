class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :user
  belongs_to :attachable, polymorphic: true

  has_mongoid_attached_file :file

  validates_attachment :file, :content_type => {:content_type => %w(image/jpeg image/jpg image/png image/gif application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
end
