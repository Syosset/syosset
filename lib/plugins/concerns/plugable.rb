module Concerns
  # Models which can have plugins should inclue this concern
  module Plugable
    extend ActiveSupport::Concern

    included do
      field :enabled_plugins, type: Array, default: []
    end
  end
end
