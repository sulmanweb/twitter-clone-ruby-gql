module Mutations
  # @note: This is the mutation that will be used to like a tweet.
  class LikeTweet < BaseMutation
    description 'Like a tweet'

    argument :tweet_id, ID, required: true, description: 'The ID of the tweet to like'

    field :errors, [String], null: true, description: 'Errors that occurred during the mutation'
    field :success, Boolean, null: false, description: 'Whether the mutation was successful'
    field :tweet, Types::Objects::TweetType, null: true, description: 'The tweet that was liked'

    def resolve(tweet_id:)
      Tweets::LikeTweetService.call(tweet_id:, user: context[:current_user])
    end
  end
end
