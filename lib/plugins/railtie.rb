module Syosset
  module Plugins
    class Railtie < Rails::Railtie
      config.after_initialize do
        puts "Loading plugin framework..."
        Dir[Dir.pwd + '/lib/plugins/**/*.rb'].each do |file|
          puts "Requiring #{file}"
          require file
        end
        puts "Plugin framework initialized!"

        puts "Loading plugins..."
        Dir[Dir.pwd + '/vendor/plugins/**/*.rb'].each do |file|
          path = file.split("/")
          if path[-1] == "engine.rb"
            puts "Loading #{file}"
            require file
            plugin = "Syosset::Plugins::#{path[-2].camelize}::Engine".constantize
            puts "Attempting to mount on /plugins/#{plugin.plugin_name.parameterize}"
            Rails.application.routes.draw do
              mount plugin => "plugins/#{plugin.plugin_name.parameterize}"
            end
            puts "Loaded #{plugin.plugin_name} { #{plugin.plugin_description} }"
          end
        end
      end
    end
  end
end
