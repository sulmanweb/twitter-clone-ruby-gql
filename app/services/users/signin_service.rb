module Users
  # @note: This is the service that will be used to authenticate a user and create new session.
  # @param [String] username
  # @param [String] password
  # @return [Struct] result with the user, auth token and error
  # @example
  #  Users::SigninService.call(username: 'username', password: 'password')
  # @example result
  #  result.user # => User
  #  result.auth_token # => String
  #  result.errors # => Array
  # @step: 1 - Find the user.
  # @step: 2 - Authenticate the user with password.
  # @step: 3 - Create the session.
  # @step: 4 - Encode the session token.
  # @step: 5 - Return the result.
  class SigninService
    attr_accessor :username, :password, :result

    # @note: This is the constructor of the service.
    def initialize(username:, password:)
      @username = username
      @password = password
      # @note: This is the struct that will be used to return the result of the service.
      @result = Struct.new(:user, :auth_token, :errors)
    end

    # @note: This is the method that will be called to execute the service.
    def call
      user = User.find_by(username:)
      # @note: This is the validation of the user.
      return result.new(nil, nil, ['Invalid username or password']) unless user&.authenticate(password)

      session = user.sessions.create!
      auth_token = "Bearer #{JsonWebToken.encode({ token: session.token })}"
      result.new(user, auth_token, nil)
    end

    # @note: This is the method that will be called to execute the service.
    class << self
      def call(username:, password:)
        new(username:, password:).call
      end
    end
  end
end
