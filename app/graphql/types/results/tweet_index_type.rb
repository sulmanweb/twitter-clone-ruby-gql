module Types
  module Results
    # @note: This is the query for the current user.
    class TweetIndexType < Types::BaseObject
      description 'Get the current user'

      field :errors, [String], null: true, description: 'The errors that occurred'
      field :success, Boolean, null: false, description: 'Whether the query was successful'
      field :tweets, Types::Objects::TweetType.connection_type, null: true, description: 'Tweet collection'
    end
  end
end
