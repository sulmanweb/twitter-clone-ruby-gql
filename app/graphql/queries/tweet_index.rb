module Queries
  # @note: This is the query for all tweets.
  class TweetIndex < Queries::BaseQuery
    description 'Get all tweets'

    argument :query, String, required: false, description: 'The query to search for tweets'
    argument :user_id, ID, required: false, description: 'The ID of the user'

    type Types::Results::TweetIndexType, null: false

    def resolve(query: nil, user_id: nil)
      if user_id.present?
        user = User.find_by(id: user_id)
        return { success: false, tweets: nil, errors: ['User not found'] } if user.blank?

        if query.present?
          { success: true, tweets: user.tweets.search_by_text(query), errors: nil }
        else
          { success: true, tweets: user.tweets.order(id: :desc), errors: nil }
        end
      elsif query.present?
        { success: true, tweets: Tweet.search_by_text(query).includes(:user), errors: nil }
      else
        { success: true, tweets: Tweet.all.includes(:user).order(id: :desc), errors: nil }
      end
    end
  end
end
