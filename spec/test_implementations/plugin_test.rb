module Syosset::Plugins
  # In a real implementation, this would set up a relation on all plugables
  module PluginModel
    extend ActiveSupport::Concern

    included do
      field :coolio, type: Boolean, default: false
    end
  end

  # In a real implementation, this would be the entrypoint of the Rails engine
  class TestPlugin
    include Plugin

    name "Test Plugin"
    description "The coolest test ever"
    plugable_include PluginModel
  end

  # The main rails app would be like this, the plugin does not need to do this
  # For example... Department, Course, and Activity might look like htis
  class PlugableModel
    include Mongoid::Document
    include Concerns::Plugable
  end
end
