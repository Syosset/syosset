module Concerns
  module Descriptable
    extend ActiveSupport::Concern

    included do
      field :name, type: String
      field :short_description, type: String

      # DEPRECATED -  use markdown instead
      field :content, type: String

      field :markdown, type: String
    end
  end
end
