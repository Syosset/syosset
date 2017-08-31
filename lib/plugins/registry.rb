module Syosset
  module Plugins
    module Registry

      mattr_accessor :plugins, :callbacks
      @@plugins = []
      @@callbacks = {on_register: [], on_enable: [], on_disable: []}

      def self.register(klass, options = {})
        @@plugins << [klass, options]
        @@callbacks[:on_register].each {|x| x.call }
      end

      def self.enabled? plugin_class, plugable
        raise "Plugin must include Syosset::Plugins::Plugin" unless plugin_class.include? Syosset::Plugins::Plugin
        raise "Plugable must include Concerns::Plugable" unless plugable.class.include? Concerns::Plugable
        plugable.enabled_plugins.include? plugin_class.to_s
      end

      def self.enable plugin_class, plugable
        raise "Plugin must include Syosset::Plugins::Plugin" unless plugin_class.include? Syosset::Plugins::Plugin
        raise "Plugable must include Concerns::Plugable" unless plugable.class.include? Concerns::Plugable
        plugable.enabled_plugins << plugin_class.to_s
        @@callbacks[:on_enable].each {|x| x.call(plugin_class) } if plugable.save
      end

      def self.disable plugin_class, plugable
        raise "Plugin must include Syosset::Plugins::Plugin" unless plugin_class.include? Syosset::Plugins::Plugin
        raise "Plugable must include Concerns::Plugable" unless plugable.class.include? Concerns::Plugable
        plugable.enabled_plugins.delete(plugin_class.to_s)
        @@callbacks[:on_disable].each {|x| x.call(plugin_class) } if plugable.save
      end

      def self.on_register(&callback)
        @@callbacks[:on_register] << callback
      end

      def self.on_enable(&callback)
        @@callbacks[:on_enable] << callback
      end

      def self.on_disable(&callback)
        @@callbacks[:on_disable] << callback
      end
    end
  end
end
