module Types
  module Objects
    # @note: This is the type that will be used to represent a retweet.
    class RetweetType < Types::BaseObject
      description 'A retweet'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'The creation date of the retweet'
      field :id, ID, null: false, description: 'The id of the retweet'
      field :tweet, Types::Objects::TweetType, null: false, description: 'The tweet that was retweeted'
      field :user, Types::Objects::UserType, null: false, description: 'The user that created the retweet'
    end
  end
end
