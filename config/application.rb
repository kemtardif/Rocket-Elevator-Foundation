require_relative 'boot'

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# TED / JORGE - Theme of BackOffice
ENV['RAILS_ADMIN_THEME'] = 'rollincode'

module Rocket_Elevators_Information_System
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    
  end
end
