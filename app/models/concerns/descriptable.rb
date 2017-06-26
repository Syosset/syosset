module Concerns
  module Descriptable
    extend ActiveSupport::Concern

    included do
      field :name, type: String
      field :short_description, type: String
      field :content, type: String
    end
  end
end
