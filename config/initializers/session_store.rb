Rails.application.config.session_store :cookie_store, key: '_your_app_session', same_site: :lax
Rails.application.config.session_store :cache_store