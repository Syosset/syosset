module Summarizable
  extend ActiveSupport::Concern

  included do
    field :name, type: String
    field :summary, type: String

    validates :name, presence: true, uniqueness: true
  end
end