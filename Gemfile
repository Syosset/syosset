ruby '2.3.4'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Rails framework
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.11'

# # Use HAML to render templates
gem 'haml-rails', '~> 1'
# Use redcarpet to render Markdown content
gem 'redcarpet', '~> 3'

# Use SCSS to render stylesheets
gem 'sass-rails', '~> 5'
# Use autoprefixer-rails for automatic browser prefixing
gem 'autoprefixer-rails', '~> 7'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 4'

# Turbolinks makes navigating the app faster
gem 'turbolinks', '~> 5.1'
# Serve jquery and jquery-ui to clients
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Use font-awesome for icons
gem 'font-awesome-rails', '~> 4'
# Use flexslider
gem 'flex-slider-rails', '~> 2'

# Pagination
gem 'kaminari'
gem 'kaminari-mongoid'
gem 'kaminari-views-bootstrap'

# Peek shows performance stats
gem 'peek'
gem 'peek-git'
gem 'peek-host', github: 'kailan/peek-host'
gem 'peek-redis'
gem 'peek-mongo'
gem 'peek-resque', github: 'kailan/peek-resque'

# Integrations
gem 'slack-ruby-client', '~> 0.11'

# Paperclip handles file uploads
gem 'mongoid-paperclip', '~> 0.0.11'
# Files are stored in S3
gem 'aws-sdk', '~> 3'

# Error Reporting
gem 'sentry-raven'

# Security Headers
gem 'secure_headers', '~> 5'

# Use Devise for user authentication
gem 'devise', '~> 4.4'
# Allow users to sign in using Google accounts
gem 'omniauth-google-oauth2', github: 'zquestz/omniauth-google-oauth2'

# Use scram for authorization
gem 'scram', '~> 0.1'
# Use groupify in conjunction with Scram
gem 'groupify', '~> 0.9'

# Use Mongoid for ODM
gem 'mongoid', '~> 6.3'
# Use mongoid-slug for pretty urls
gem 'mongoid-slug'
# Use mongoid_search for model searching
gem 'mongoid_search'
# Use mongoid-history for auditing
gem 'mongoid-history'
# Use mongoid_userstamp to store modifier information automatically
gem 'mongoid_userstamp', github: 'AndreiMotinga/mongoid_userstamp'
# Use diffy to compute diffs between documents for auditing
gem 'diffy'
# Use Redis for caching
gem 'redis'
# Use Resque for jobs
gem 'resque'

gem 'aasm'

gem 'record_tag_helper' # Thanks DHH
# To cleanly organize our APIs
gem 'jsonapi-rails'

group :development, :test do
  # Allow app to be configured with .env file
  gem 'dotenv-rails'
  # Debugging during execution with pry
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails', '~> 3.7'
  gem 'factory_girl'
  gem 'rails-controller-testing'
  gem 'guard-rspec', require: false
  gem 'clockwork', github: 'Rykian/clockwork'
  gem 'capybara', '~> 2'
  gem 'poltergeist', '~> 1'
  gem 'launchy', '~> 2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
