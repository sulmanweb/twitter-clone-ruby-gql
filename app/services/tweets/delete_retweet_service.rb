module Tweets
  # @note: This service is used to delete a retweet.
  # @param tweet_id [Integer] The tweet to be unretweeted.
  # @param user [User] The user who is deleting the retweet.
  # @return [Struct] A struct with the following attributes:
  # - success [Boolean] A boolean indicating if the retweet was deleted successfully.
  # - errors [Array] An array of errors.
  # - tweet [Tweet] The context tweet.
  # @example
  #  Tweets::DeleteRetweetService.new(tweet_id: tweet.id, user: current_user).call
  class DeleteRetweetService
    attr_reader :tweet_id, :user, :result

    def initialize(tweet_id:, user:)
      @tweet_id = tweet_id
      @user = user
      @result = Struct.new(:success, :errors, :tweet)
    end

    def call # rubocop:disable Metrics/AbcSize
      return result.new(false, ['You need to be logged in to perform this action.'], nil) if user.blank?

      tweet = Tweet.find_by(id: tweet_id)
      return result.new(false, ['The tweet you are trying to unretweet does not exist.'], nil) if tweet.blank?

      retweet = Retweet.find_by(tweet:, user:)
      return result.new(false, ['You have not retweeted this tweet.'], nil) if retweet.blank?

      if retweet.destroy
        result.new(true, nil, tweet)
      else
        result.new(false, retweet.errors.full_messages, nil)
      end
    end

    # @note: This is the method that will be called to execute the service.
    class << self
      def call(tweet_id:, user:)
        new(tweet_id:, user:).call
      end
    end
  end
end
