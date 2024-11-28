class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  skip_before_action :verify_authenticity_token, if: -> { request.env['omniauth.origin'].present? }  
  protect_from_forgery unless: -> { request.path.start_with?('/users/auth/') }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end  
end
