module Mutations
  # @note: This is the mutation that will be used to create a new tweet.
  class CreateTweet < Mutations::BaseMutation
    description 'Create a new tweet'

    argument :text, String, required: true, description: 'The text of the tweet'

    field :errors, [String], null: true, description: 'The errors of the mutation'
    field :success, Boolean, null: false, description: 'A boolean indicating if the tweet was created successfully'
    field :tweet, Types::Objects::TweetType, null: true, description: 'The tweet'

    def resolve(text:)
      Tweets::CreateService.call(text:, user: context[:current_user])
    end
  end
end
