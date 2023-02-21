module Queries
  # @note: This is the query for all tweets.
  class TweetIndex < Queries::BaseQuery
    description 'Get all tweets'

    argument :user_id, ID, required: false, description: 'The ID of the user'

    type Types::Results::TweetIndexType, null: false

    def resolve(user_id: nil)
      if user_id.present?
        user = User.find(user_id)
        { success: true, tweets: user.tweets, errors: nil }
      else
        { success: true, tweets: Tweet.all.includes(:user), errors: nil }
      end
    end
  end
end
