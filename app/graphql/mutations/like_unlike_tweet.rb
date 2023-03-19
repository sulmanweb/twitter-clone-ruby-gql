module Mutations
  # @note: This mutation is used to like or unlike a tweet
  class LikeUnlikeTweet < BaseMutation
    description 'Like or unlike a tweet'

    argument :tweet_id, ID, required: true, description: 'ID of the tweet to like or unlike'

    field :errors, [String], null: true, description: 'Errors if any'
    field :success, Boolean, null: false, description: 'Indicates if the operation was successful'
    field :tweet, Types::Objects::TweetType, null: true, description: 'The tweet'

    def resolve(tweet_id:)
      Tweets::LikeUnlikeTweetService.call(tweet_id:, user: context[:current_user])
    end
  end
end
