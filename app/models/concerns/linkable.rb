module Concerns
  module Linkable
    extend ActiveSupport::Concern

    included do
      has_many :links, as: :linkable, class_name: 'Link'

      before_destroy do
        links.destroy_all
      end
    end
  end
end
