module Tweets
  # @note This service is used to add mentions for a tweet
  # @param tweet [Tweet] the tweet to add mentions for
  # @return [void]
  # @example
  #   Tweets::AddMentionsForTweet.call(tweet)
  class AddMentionsForTweet
    attr_reader :tweet

    def initialize(tweet:)
      @tweet = tweet
    end

    def call
      tweet.text.scan(/@([a-z0-9_.]+)/).flatten.each do |username|
        user = User.find_by(username:)
        next unless user

        Mention.find_or_create_by!(tweet:, user:)
      end
    end

    def self.call(tweet:)
      new(tweet:).call
    end
  end
end
