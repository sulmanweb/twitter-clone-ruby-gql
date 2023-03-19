module Mutations
  # @note: Unlike a tweet
  class UnlikeTweet < BaseMutation
    description 'Unlike a tweet'

    argument :tweet_id, ID, required: true, description: 'The ID of the tweet to unlike'

    field :errors, [String], null: true, description: 'Errors that prevented the tweet from being unliked'
    field :success, Boolean, null: false, description: 'Whether the tweet was unliked successfully'
    field :tweet, Types::Objects::TweetType, null: true, description: 'The tweet that was unliked'

    def resolve(tweet_id:)
      Tweets::UnlikeTweetService.call(tweet_id:, user: context[:current_user])
    end
  end
end
