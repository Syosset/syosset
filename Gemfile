ruby '2.3.4'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', groups: [:development, :test]

gem 'clockwork', github: "Rykian/clockwork"
gem 'capybara', '~> 2.7', '>= 2.7.1'
gem 'poltergeist', '~> 1.15'
gem 'launchy', '~> 2.4', '>= 2.4.3'

gem 'jquery-ui-rails'
gem 'jquery-rails'
gem 'git', '~> 1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use autoprefixer-rails for automatic browser prefixing
gem 'autoprefixer-rails', '~> 7.1.3'
# Use HAML for templates
gem 'haml-rails', '~> 0.9'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use font-awesome for icons
gem "font-awesome-rails", '~> 4.7.0.2'
# Use flexslider
gem 'flex-slider-rails', '~> 2.6.3'
# Use tinymce
gem 'tinymce-rails'

# Pagination
gem 'kaminari'
gem 'kaminari-mongoid'
gem 'kaminari-views-bootstrap'

# Peek shows performance stats
gem 'peek'
gem 'peek-git'
gem 'peek-host', github: "kailan/peek-host"
gem 'peek-redis'
gem 'peek-mongo'
gem 'peek-resque', github: "kailan/peek-resque"

# Integrations
gem 'slack-ruby-client', '~> 0.9'

# Paperclip handles file uploads
gem 'mongoid-paperclip', '~> 0.0.11'
# Files are stored in S3
gem 'aws-sdk', '~> 2.10'


# Error Reporting
gem "sentry-raven"

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Devise for user authentication
gem 'devise', '~> 4.3'
gem 'omniauth-google-oauth2', github: "zquestz/omniauth-google-oauth2"
# Use scram for authorization
gem 'scram', '~> 0.1.2'
# Use groupify in conjunction with Scram
gem 'groupify', '~> 0.8.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Mongoid for ODM
gem 'mongoid', '~> 6.1.0'
# Use mongoid-slug for pretty urls
gem 'mongoid-slug', '~> 5.2'
# Use mongoid_search for model searching
gem 'mongoid_search'
# Use mongoid-history for auditing
gem 'mongoid-history'
# Use Redis for caching
gem 'redis'
# Use Resque for jobs
gem 'resque'

gem 'aasm', '~> 4.11'

gem 'record_tag_helper', '~> 1.0' # Thanks DHH
# To cleanly organize our APIs
gem 'jsonapi-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'

  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl'
  gem 'rails-controller-testing'
  gem 'guard-rspec', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
