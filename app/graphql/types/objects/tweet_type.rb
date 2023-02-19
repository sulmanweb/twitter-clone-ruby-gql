module Types
  module Objects
    # @note: This is the type that will be used to represent a tweet.
    class TweetType < Types::BaseObject
      description 'A tweet'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'The creation date of the tweet'
      field :id, ID, null: false, description: 'The id of the tweet'
      field :is_reply, Boolean, null: false, description: 'A boolean indicating if the tweet is a reply', method: :reply?
      field :is_retweet, Boolean, null: false, description: 'A boolean indicating if the tweet is a retweet'
      field :text, String, null: true, description: 'The text of the tweet'
      field :user, Types::Objects::UserType, null: false, description: 'The user that created the tweet'
    end
  end
end
