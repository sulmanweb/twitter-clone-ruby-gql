module Tweets
  # @note: This service is used to like/unlike a tweet
  # @param tweet_id: [Integer] The tweet id
  # @param user: [User] The user who is liking/unliking the tweet
  # @return [Struct] The result of the service
  # - success: [Boolean] True if the tweet was liked/unliked successfully
  # - errors: [Array] The errors if the tweet was not liked/unliked successfully
  # - tweet: [Tweet] The tweet that was liked/unliked
  # @example:
  #    Tweets::LikeUnlikeTweetService.call(tweet_id: 1, user: current_user)
  class LikeUnlikeTweetService
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
      else
        tweet.likes.create(user:)
      end

      result.new(true, nil, tweet)
    end

    class << self
      def call(tweet_id:, user:)
        new(tweet_id:, user:).call
      end
    end
  end
end
