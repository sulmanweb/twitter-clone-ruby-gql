module Tweets
  # @note: This service is used to create a new retweet.
  # @param tweet [Tweet] The tweet to be retweeted.
  # @param user [User] The user who is creating the retweet.
  # @return [Struct] A struct with the following attributes:
  # - success [Boolean] A boolean indicating if the retweet was created successfully.
  # - errors [Array] An array of errors.
  # - retweet [Retweet] The retweet created.
  # @example
  #  Tweets::CreateRetweetService.new(tweet: tweet, user: current_user).call
  class CreateRetweetService
    attr_reader :tweet_id, :user, :result

    def initialize(tweet_id:, user:)
      @tweet_id = tweet_id
      @user = user
      @result = Struct.new(:success, :errors, :tweet)
    end

    def call # rubocop:disable Metrics/AbcSize
      return result.new(false, ['You need to be logged in to perform this action.'], nil) if user.blank?

      tweet = Tweet.find_by(id: tweet_id)
      return result.new(false, ['The tweet you are trying to retweet does not exist.'], nil) if tweet.blank?

      retweet = Retweet.new(tweet:, user:)

      if retweet.save
        result.new(true, nil, tweet)
        # @todo: Send a notification to the tweet owner
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
