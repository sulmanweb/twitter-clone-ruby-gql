module Users
  # @note: This service is used to follow a user.
  # @param user [User] The user who is following the other user.
  # @param followed_user_id [Integer] The user's id who is being followed.
  # @return [Struct] A struct with the following attributes:
  # - success [Boolean] A boolean indicating if the user was followed successfully.
  # - errors [Array] An array of errors.
  # @example
  # Users::FollowService.call(user: current_user, followed_user: user)
  class FollowService
    attr_reader :user, :followed_user_id, :result

    # @note: This is the method that will be called to execute the service.
    def initialize(user:, followed_user_id:)
      @user = user
      @followed_user_id = followed_user_id
      @result = Struct.new(:success, :errors)
    end

    # @note: This is the method that will be called to execute the service.
    def call # rubocop:disable Metrics/AbcSize
      return result.new(false, ['You need to be logged in to perform this action.']) if user.blank?

      followed_user = User.find_by(id: followed_user_id)
      return result.new(false, ['User could not be unfollowed.']) if followed_user.blank?

      followship = user.active_relationships.build(followed_id: followed_user_id)
      if followship.save
        result.new(true, nil)
      else
        result.new(false, followship.errors.full_messages)
      end
    end

    # @note: This is the method that will be called to execute the service.
    class << self
      def call(user:, followed_user_id:)
        new(user:, followed_user_id:).call
      end
    end
  end
end
