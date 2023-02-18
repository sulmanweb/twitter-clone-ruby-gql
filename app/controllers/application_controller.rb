# Purpose: To provide a base class for all controllers to inherit from.
class ApplicationController < ActionController::API
  # @note: This method gets auth header if present
  def auth_header
    request.headers['Authorization']&.split&.last
  end

  # @note: This method decodes the auth header
  def decoded_auth_header
    auth_header && JsonWebToken.decode(auth_header)
  end

  # @note: This method gets the current session
  def current_session
    return unless decoded_auth_header

    session = Session.active.find_by(token: decoded_auth_header[:token])
    session&.used!
    @current_session ||= session
  end

  # @note: This method gets the current user
  def current_user
    @current_user ||= current_session&.user
  end
end
