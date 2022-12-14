require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EssenciasFluir
  class Application < Rails::Application
    config.assets.paths << Rails.root.join('app', 'vendor', 'assets', 'fonts')
    # config.assets.paths += %W("#{Rails.root}/public/assets/fonts")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'pt-br'

    # Do not swallow errors in after_commit/after_rollback callbacks.
		config.active_record.raise_in_transactional_callbacks = true
		
		Correios::Frete.configure do |config|
			config.log_enabled = true   # Desabilita o log
			config.log_level = :debug    # Altera o nível do log
			config.logger = Rails.logger # Usa o logger do Rails
		end
  end
end
