module Tweets
  # @note: This class is responsible for adding hash tags for a tweet
  # @param tweet: [Tweet] tweet object
  # @return void
  # @example: Tweets::AddHashTagsForTweet.call(tweet: tweet)
  class AddHashTagsForTweet
    attr_reader :tweet

    def initialize(tweet:)
      @tweet = tweet
    end

    def call
      tweet.text.scan(/#(\w+)/).flatten.each do |tag_name|
        tweet.hash_tags.find_or_create_by!(tag: tag_name)
      end
    end

    def self.call(tweet:)
      new(tweet:).call
    end
  end
end
