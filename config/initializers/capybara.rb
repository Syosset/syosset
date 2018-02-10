if Rails.env.test?
  require 'capybara/poltergeist'

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end

  # Configure Capybara to use Poltergeist as the driver
  Capybara.default_driver = :poltergeist
end