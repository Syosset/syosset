module Concerns
  module Plugins
    module Pluggable
      extend ActiveSupport::Concern

      included do
        has_many :plugins, :as => :pluggable, :class_name => "Plugin"

        before_destroy do
          plugins.destroy_all
        end
      end
    end
  end
end
