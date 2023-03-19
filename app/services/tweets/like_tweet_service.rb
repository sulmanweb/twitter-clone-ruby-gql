module Tweets
  # @note: This is the service that will be used to like a tweet.
  # @param tweet_id [Integer] The id of the tweet to be liked.
  # @param user [User] The user that is liking the tweet.
  # @return [Struct] A struct with the result of the operation.
  # - success [Boolean] A boolean indicating if the operation was successful.
  # - errors [Array] An array of errors.
  # - tweet [Tweet] The tweet that was liked.
  # @example
  # LikeTweetService.call(tweet_id: 1, user: current_user)
  class LikeTweetService
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

      liked = tweet.likes.build(user:)
      if liked.save
        result.new(true, nil, tweet)
      else
        result.new(false, liked.errors.full_messages, nil)
      end
    end

    def self.call(tweet_id:, user:)
      new(tweet_id:, user:).call
    end
  end
end
