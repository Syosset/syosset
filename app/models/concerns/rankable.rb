module Rankable
  extend ActiveSupport::Concern

  included do
    field :priority, type: Integer, default: 0
    scope :by_priority, -> { order(priority: :asc) }
  end
end
