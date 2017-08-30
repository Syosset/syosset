$LOAD_PATH << File.join(Rails.root, 'lib/plugins')

Dir[Rails.root + 'lib/plugins/**/*.rb'].each do |file|
    require file
end
