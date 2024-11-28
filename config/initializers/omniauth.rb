Rails.application.config.middleware.use OmniAuth::Builder do
  provider :auth0, ENV['AUTH0_CLIENT_ID'], ENV['AUTH0_CLIENT_SECRET'], domain: ENV['AUTH0_DOMAIN']
  OmniAuth.config.logger = Rails.logger

end
