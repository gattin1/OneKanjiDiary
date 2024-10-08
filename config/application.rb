# frozen_string_literal: true

# Applicationクラスは、アプリケーション全体の設定を管理します。
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
# アプリケーション全体の設定を管理するクラス
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # タイムゾーンを日本標準時に設定
    config.time_zone = 'Tokyo'

    # データベースに保存される時間を日本時間にする
    config.active_record.default_timezone = :local

    config.active_job.queue_adapter = :sidekiq

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.test_framework nil
    end

    config.autoload_paths += %W[#{config.root}/app/helpers]

    config.i18n.default_locale = :ja

    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'https://9ae6-133-200-128-160.ngrok-free.app'
        resource '*', headers: :any, methods: %i[get post put patch delete options head]
      end
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
