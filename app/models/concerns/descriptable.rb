module Concerns
  module Descriptable
    extend ActiveSupport::Concern

    included do
      field :name, type: String, default: ""
      field :short_description, type: String, default: ""
      field :content, type: String, default: ""
    end
  end
end
