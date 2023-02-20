module Users
  # @note: This class is used to unfollow a user.
  # @param [User] user
  # @param [Integer] followed_user_id
  # @return [Struct]
  # @example: Users::UnFollowService.new(user, followed_user_id).call
  class UnFollowService
    attr_reader :user, :followed_user_id, :result

    # @note: This method is used to initialize the class.
    def initialize(user, followed_user_id)
      @user = user
      @followed_user_id = followed_user_id
      @result = Struct.new(:success, :errors)
    end

    # @note: This method is used to call the class.
    def call # rubocop:disable Metrics/AbcSize
      return result.new(false, ['You need to login to perform this action']) if user.blank?

      followed_user = User.find_by(id: followed_user_id)
      return result.new(false, ['User could not be unfollowed.']) if followed_user.blank?

      followship = user.active_relationships.find_by(followed_id: followed_user_id)
      return result.new(false, ['User could not be unfollowed.']) if followship.blank?

      followship.destroy
      result.new(true, nil)
    end

    class << self
      # @note: This method is used to call the class.
      def call(user, followed_user_id)
        new(user, followed_user_id).call
      end
    end
  end
end
