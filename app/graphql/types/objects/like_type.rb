module Types
  module Objects
    # @note: LikeType
    class LikeType < Types::Objects::BaseObject
      description 'LikeType'

      field :id, ID, null: false, description: 'ID'
      field :tweet, Types::Objects::TweetType, null: false, description: 'Tweet'
      field :user, Types::Objects::UserType, null: false, description: 'User'
    end
  end
end
