require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FippoMap
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators do |g|
      g.assets false
      g.skip_routes false
      g.test_framework :rspec,    # RSpecを使用
        controller_specs: false,  # controller specは作らない
        view_specs: false,        # view specは作らない
        helper_specs: false,      # helper specは作らない
        routing_specs: false      # routing specは作らない
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
