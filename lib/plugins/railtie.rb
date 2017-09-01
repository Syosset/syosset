module Syosset
  module Plugins
    class Railtie < Rails::Railtie
      Dir[Dir.pwd + '/lib/plugins/**/*.rb'].each do |file|
        puts file
        require file
      end
    end
  end
end
