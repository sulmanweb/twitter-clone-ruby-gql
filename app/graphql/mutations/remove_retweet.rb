module Mutations
  # @note: This is the mutation that will be used to delete a retweet.
  class RemoveRetweet < Mutations::BaseMutation
    description 'Remove a retweet'

    argument :tweet_id, ID, required: true, description: 'The ID of the tweet to be unretweeted'

    field :errors, [String], null: true, description: 'The errors of the mutation'
    field :success, Boolean, null: false, description: 'A boolean indicating if the retweet was deleted successfully'
    field :tweet, Types::Objects::TweetType, null: true, description: 'The tweet'

    def resolve(tweet_id:)
      Tweets::DeleteRetweetService.call(tweet_id:, user: context[:current_user])
    end
  end
end
