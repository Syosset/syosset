module Syosset
  module Plugins
    module Plugin
      extend ActiveSupport::Concern

      included do
         cattr_accessor :plugin_name, :plugin_description
      end

      module ClassMethods
        def name(name)
          self.plugin_name = name
        end

        def description(description)
          self.plugin_description = description
        end
      end
    end
  end
end
