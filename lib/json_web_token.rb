# @note: This class is used to encode and decode the JWT token.
class JsonWebToken
  require 'jwt'

  # @note: This method is used to initialize the secret key.
  def initialize
    @secret = Rails.application.credentials.jwt_secret
  end

  # @note: This method is used to encode the payload.
  # @param [Hash] payload
  # @return [String]
  def encode(payload)
    JWT.encode(payload, @secret, 'HS256')
  end

  # @note: This method is used to decode the token.
  # @param [String] token
  # @return [Hash]
  def decode(token)
    JWT.decode(token, @secret, true, algorithm: 'HS256')[0].symbolize_keys
  rescue StandardError
    nil
  end

  # @note: This method is used to delegate the methods to the class.
  class << self
    delegate :encode, to: :new

    delegate :decode, to: :new
  end
end
