module Users
  # @note: This is the service that will be used to sign out a user.
  # @param [Session] session
  # @return [Struct] result with the errors and success
  # @example
  # Users::SignoutService.call(session: session)
  # @example result
  # result.errors # => Array
  # result.success # => Boolean
  # @step: 1 - Validate the session.
  # @step: 2 - Inactive the session.
  # @step: 3 - Return the result.
  class SignoutService
    attr_accessor :session, :result

    # @note: This is the constructor of the service.
    def initialize(session:)
      @session = session
      # @note: This is the struct that will be used to return the result of the service.
      @result = Struct.new(:errors, :success)
    end

    # @note: This is the method that will be called to execute the service.
    def call
      return result.new(['You need to signin to perform this action'], false) if session.nil?

      session.inactive!
      result.new(nil, true)
    end

    # @note: This is the method that will be called to execute the service.
    class << self
      def call(session:)
        new(session:).call
      end
    end
  end
end
