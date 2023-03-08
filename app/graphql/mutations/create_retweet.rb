module Mutations
  # @note: This is the mutation that will be used to create a new tweet.
  class CreateRetweet < Mutations::BaseMutation
    description 'Create a new retweet'

    argument :tweet_id, ID, required: true, description: 'The ID of the tweet to be retweeted'

    field :errors, [String], null: true, description: 'The errors of the mutation'
    field :success, Boolean, null: false, description: 'A boolean indicating if the tweet was created successfully'
    field :tweet, Types::Objects::TweetType, null: true, description: 'The tweet'

    def resolve(tweet_id:)
      Tweets::CreateRetweetService.call(tweet_id:, user: context[:current_user])
    end
  end
end
