module Mutations
  # @note: This mutation is used to delete a tweet.
  class DeleteTweet < BaseMutation
    description 'Delete a tweet.'

    argument :tweet_id, ID, required: true, description: 'The id of the tweet to be deleted.'

    field :errors, [String], null: true, description: 'An array of errors.'
    field :success, Boolean, null: false, description: 'A boolean indicating if the tweet was deleted successfully.'

    def resolve(tweet_id:)
      Tweets::DeleteService.call(user: context[:current_user], tweet_id:)
    end
  end
end
