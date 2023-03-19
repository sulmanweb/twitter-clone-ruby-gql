module Tweets
  # @note: This is the service that will be used to unlike a tweet.
  # @param tweet_id [Integer] The id of the tweet to unlike.
  # @param user [User] The user that is unliking the tweet.
  # @return [Struct] A struct with the result of the operation.
  # - success [Boolean] Whether the operation was successful or not.
  # - errors [Array<String>] An array of errors if the operation was not successful.
  # - tweet [Tweet] The tweet that was unliked.
  # @example: Unlike a tweet
  #   Tweets::UnlikeTweetService.call(tweet_id: 1, user: current_user)
  class UnlikeTweetService
    attr_reader :tweet_id, :user, :result

    def initialize(tweet_id:, user:)
      @tweet_id = tweet_id
      @user = user
      @result = Struct.new(:success, :errors, :tweet)
    end

    def call # rubocop:disable Metrics/AbcSize
      return result.new(false, ['You need to be logged in to perform this action.'], nil) if user.blank?

      tweet = Tweet.find_by(id: tweet_id)
      return result.new(false, ['Tweet not found.'], nil) if tweet.blank?

      liked = tweet.likes.find_by(user:)
      if liked
        liked.destroy
        result.new(true, nil, tweet)
      else
        result.new(false, ['You have not liked this tweet.'], nil)
      end
    end

    def self.call(tweet_id:, user:)
      new(tweet_id:, user:).call
    end
  end
end
