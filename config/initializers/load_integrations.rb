require "#{Rails.root}/lib/integrations/integration_provider.rb"
Dir[Rails.root + 'lib/integrations/**/*.rb'].each { |file| require file }
