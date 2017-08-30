module Syosset
  module Plugins
    module Registry

      mattr_accessor :plugins, :callbacks
      @@plugins = []
      @@callbacks = []

      def self.register(klass, options = {})
        @@plugins << [klass, options]
        @@callbacks.each {|x| x.call }
      end

      def self.on_register(&callback)
        @@callbacks << callback
      end
    end
  end
end
