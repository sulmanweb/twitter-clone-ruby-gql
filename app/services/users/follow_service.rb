module Users
  # @note: This service is used to follow a user.
  # @param user [User] The user who is following the other user.
  # @param followed_user [User] The user who is being followed.
  # @return [Struct] A struct with the following attributes:
  # - success [Boolean] A boolean indicating if the user was followed successfully.
  # - errors [Array] An array of errors.
  # @example
  # Users::FollowService.call(user: current_user, followed_user: user)
  class FollowService
    attr_reader :user, :followed_user, :result

    # @note: This is the method that will be called to execute the service.
    def initialize(user:, followed_user:)
      @user = user
      @followed_user = followed_user
      @result = Struct.new(:success, :errors)
    end

    # @note: This is the method that will be called to execute the service.
    def call
      return result.new(false, ['You need to be logged in to perform this action.']) if user.blank?

      resp = user.follow(followed_user)
      # @todo: Send a notification to the followed user.
      if resp.is_a?(Array)
        # @note: errors
        result.new(false, resp)
      else
        # @note: success
        result.new(true, nil)
      end
    end

    # @note: This is the method that will be called to execute the service.
    class << self
      def call(user:, followed_user:)
        new(user:, followed_user:).call
      end
    end
  end
end
