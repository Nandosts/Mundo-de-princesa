require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MundoDePrincesa
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.middleware.use ActionDispatch::Session::CookieStore
    config.i18n.default_locale = :'pt-BR'

    config.assets.initialize_on_precompile = false
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load_file(env_file).each { |key, value| ENV[key.to_s] = value } if File.exist?(env_file)
    end
  end
  ENV['NODE_OPTIONS'] = '--openssl-legacy-provider'
end
