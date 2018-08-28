module Publishable
  extend ActiveSupport::Concern

  included do
    field :markdown, type: String
  end
end
