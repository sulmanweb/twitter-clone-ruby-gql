module Tweets
  # @note: This service is used to delete a tweet.
  # @param user [User] The user who is deleting the tweet.
  # @param tweet_id [Integer] The id of the tweet to be deleted.
  # @return [Struct] A struct with the following attributes:
  # - success [Boolean] A boolean indicating if the tweet was deleted successfully.
  # - errors [Array] An array of errors.
  # @example
  # Tweets::DeleteService.call(user: current_user, tweet_id: 1)
  class DeleteService
    attr_reader :user, :tweet_id, :result

    # @note: This is the method that will be called to execute the service.
    def initialize(user:, tweet_id:)
      @user = user
      @tweet_id = tweet_id
      @result = Struct.new(:success, :errors)
    end

    # @note: This is the method that will be called to execute the service.
    def call # rubocop:disable Metrics/AbcSize
      return result.new(false, ['You need to be logged in to perform this action.']) if user.blank?

      tweet = Tweet.find_by(id: tweet_id)

      return result.new(false, ['Tweet not found.']) if tweet.blank?

      return result.new(false, ['You are not allowed to delete this tweet.']) if tweet.user != user

      if tweet.destroy
        result.new(true, nil)
      else
        result.new(false, tweet.errors.full_messages)
      end
    end

    # @note: This is the method that will be called to execute the service.
    class << self
      def call(user:, tweet_id:)
        new(user:, tweet_id:).call
      end
    end
  end
end
