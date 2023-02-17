module Users
  # @note: This is the service that will be used to create a new user and a new session.
  # @param [String] username
  # @param [String] email
  # @param [String] password
  # @param [String] name
  # @return [Struct] result with the user, session and error
  # @example
  #   Users::SignupService.call(username: 'username', email: 'email', password: 'password', name: 'name')
  # @example result
  #   result.user # => User
  #   result.auth_token # => String
  #   result.errors # => Array
  # @step: 1 - Validate the user.
  # @step: 2 - Create the user and the session.
  # @step: 3 - Encode the session token.
  # @step: 4 - Return the result.
  class SignupService
    attr_accessor :username, :email, :password, :name, :result

    # @note: This is the constructor of the service.
    def initialize(username:, email:, password:, name:)
      @username = username
      @email = email
      @password = password
      @name = name
      # @note: This is the struct that will be used to return the result of the service.
      @result = Struct.new(:user, :auth_token, :errors)
    end

    # @note: This is the method that will be called to execute the service.
    def call # rubocop:disable Metrics/AbcSize
      session = nil
      user = User.new(username:, email:, password:, name:)
      # @note: This is the validation of the user.
      return result.new(nil, nil, user.errors.full_messages) unless user.valid?

      # @note: This is the transaction that will be used to create the user and the session.
      ActiveRecord::Base.transaction do
        user.save!
        session = user.sessions.create!
      end
      auth_token = "Bearer #{JsonWebToken.encode({ token: session.token })}"
      result.new(user, auth_token, nil)
    rescue StandardError => e
      result.new(nil, nil, [e.message])
    end

    class << self
      # @note: This is the method that will be called to execute the service.
      def call(username:, email:, password:, name:)
        new(username:, email:, password:, name:).call
      end
    end
  end
end
