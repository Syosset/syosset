module Syosset
  module Plugins
    # The plugin's main class (Rails engine entrypoint) should include this module
    # Note: Inclusion is not enough; you must register the plugin with the registry
    module Plugin
      extend ActiveSupport::Concern

      included do
         cattr_accessor :plugin_name, :plugin_description
      end

      module ClassMethods
        # Sets the plugin name
        def name(name)
          self.plugin_name = name
        end

        # Sets the plugin's usage
        def description(description)
          self.plugin_description = description
        end

        # Includes a module into a concern which all plugables use
        # This is useful if you want to define relations into models which can have plugins
        # Example: A photo gallery plugin might need to define a relation like department has_many :images
        def plugable_include(mod)
          Concerns::Plugable.include(mod)
        end
      end
    end
  end
end
