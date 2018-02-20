module Attachable
  extend ActiveSupport::Concern

  included do
    has_many :attachments, as: :attachable, class_name: 'Attachment'

    before_destroy do
      attachments.destroy_all
    end
  end
end