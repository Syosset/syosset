# Add your own tasks in files placed in lib/tasks ending in .rake

# Application
require_relative 'config/application'
require 'resque/tasks'

task 'resque:setup' => :environment

Rails.application.load_tasks

# Testing
unless Rails.env.production?
  require 'rubocop/rake_task'
  require 'rspec/core/rake_task'

  RuboCop::RakeTask.new
  RSpec::Core::RakeTask.new(:spec)

  task default: %i[rubocop spec]
end
